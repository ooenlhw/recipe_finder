part of 'meal_plan_bloc.dart';

abstract class MealPlanState extends Equatable {
  const MealPlanState();

  @override
  List<Object?> get props => [];
}

class MealPlanInitial extends MealPlanState {}

class MealPlanLoading extends MealPlanState {}

class MealPlanLoaded extends MealPlanState {
  final List<MealPlanModel> mealPlans;
  final List<FavoriteRecipeModel> currentRecipes;

  const MealPlanLoaded({
    required this.mealPlans,
    required this.currentRecipes,
  });

  @override
  List<Object?> get props => [mealPlans, currentRecipes];
}

class MealPlanError extends MealPlanState {
  final String message;

  const MealPlanError(this.message);

  @override
  List<Object?> get props => [message];
}

class MealPlanSaved extends MealPlanState {
  @override
  List<Object?> get props => [];
}
