import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipe/domain/usecases/get_recipe_by_id.dart';
import 'package:recipe_finder/features/recipe/domain/usecases/get_recipes_by_ingredients.dart';
import 'package:equatable/equatable.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipesByIngredients getRecipesByIngredients;
  final GetRecipeById getRecipeById;

  RecipeBloc(
      {required this.getRecipeById, required this.getRecipesByIngredients})
      : super(RecipeInitialState()) {
    on<FetchRecipesByIngredientsEvent>(_onFetchRecipesByIngredients);
    on<FetchRecipeByIdEvent>(_onFetchRecipeById);
  }

  Future<void> _onFetchRecipesByIngredients(
      FetchRecipesByIngredientsEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoadingState());
    try {
      final Either<Failure, List<RecipeModel>> recipes =
          await getRecipesByIngredients(event.ingredients);
      print('Recipes by ingredients: $recipes');
      recipes.fold((failure) => emit(RecipeErrorState(failure.message)),
          (recipes) => emit(RecipeLoadedState(recipes)));
    } catch (e) {
      emit(RecipeErrorState(
          'Failed to load recipes by ingredients: ${e.toString()}'));
    }
  }

  Future<void> _onFetchRecipeById(
      FetchRecipeByIdEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoadingState());
    try {
      final List<RecipeModel> recipes = await getRecipeById(event.id);
      print('Recipe by id: $recipes');
      emit(RecipeLoadedState(recipes));
    } catch (e) {
      emit(RecipeErrorState('Failed to load recipe by id: ${e.toString()}'));
    }
  }
}
