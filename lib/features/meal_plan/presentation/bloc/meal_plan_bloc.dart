import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/add_favorites_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/delete_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/load_meal_plans.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/save_meal_plan.dart';
part 'meal_plan_event.dart';
part 'meal_plan_state.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final LoadMealPlans loadMealPlans;
  final SaveMealPlan saveMealPlan;
  final DeleteMealPlan deleteMealPlan;
  final AddFavoritesMealPlan addFavoritesMealPlan;
  List<FavoriteRecipeModel> currentRecipes = [];

  MealPlanBloc({
    required this.loadMealPlans,
    required this.saveMealPlan,
    required this.deleteMealPlan,
    required this.addFavoritesMealPlan,
  }) : super(MealPlanInitial()) {
    on<LoadMealPlansEvent>(_onLoadMealPlans);
    on<SaveMealPlanEvent>(_onSaveMealPlan);
    on<DeleteMealPlanEvent>(_onDeleteMealPlan);
    on<AddFavoritesMealPlanEvent>(_onAddFavoritesMealPlan);
  }

  Future<void> _onLoadMealPlans(
    LoadMealPlansEvent event,
    Emitter<MealPlanState> emit,
  ) async {
    emit(MealPlanLoading());
    try {
      final mealPlansMap = await loadMealPlans();
      final mealPlansList = mealPlansMap.entries.map((entry) {
        final id = entry.key;
        final recipeModels = entry.value.expand((m) => m.recipes).toList();
        return MealPlanModel(
          id: id,
          recipes: recipeModels,
          createdAt: entry.value.first.createdAt,
        );
      }).toList();

      emit(MealPlanLoaded(
        mealPlans: mealPlansList,
        currentRecipes: currentRecipes,
      ));
    } catch (error) {
      emit(MealPlanError("Failed to load meal plans: ${error.toString()}"));
    }
  }

  Future<void> _onSaveMealPlan(
    SaveMealPlanEvent event,
    Emitter<MealPlanState> emit,
  ) async {
    emit(MealPlanLoading());
    try {
      print(
          'weekKey: ${event.weekKey}, favoriteRecipes to Save Meal Plan: ${event.favoriteRecipes.first.title}');
      await saveMealPlan(event.weekKey, event.favoriteRecipes);
      add(LoadMealPlansEvent());
      emit(MealPlanSaved());
    } catch (e) {
      emit(MealPlanError("Failed to save meal plan: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteMealPlan(
    DeleteMealPlanEvent event,
    Emitter<MealPlanState> emit,
  ) async {
    emit(MealPlanLoading());
    try {
      await deleteMealPlan(event.id);
      add(LoadMealPlansEvent());
    } catch (e) {
      emit(MealPlanError("Failed to delete meal plan: ${e.toString()}"));
    }
  }

  void _onAddFavoritesMealPlan(
    AddFavoritesMealPlanEvent event,
    Emitter<MealPlanState> emit,
  ) {
    if (!currentRecipes.contains(event.favoriteRecipes)) {
      currentRecipes.add(event.favoriteRecipes);
    }
    if (state is MealPlanLoaded) {
      final currentState = state as MealPlanLoaded;
      emit(MealPlanLoaded(
        mealPlans: currentState.mealPlans,
        currentRecipes: currentRecipes,
      ));
    }
  }
}
