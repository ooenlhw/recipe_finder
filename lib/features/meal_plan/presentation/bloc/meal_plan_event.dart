part of 'meal_plan_bloc.dart';

abstract class MealPlanEvent extends Equatable {
  const MealPlanEvent();

  @override
  List<Object?> get props => [];
}

class LoadMealPlansEvent extends MealPlanEvent {
  @override
  List<Object?> get props => [];
}

class SaveMealPlanEvent extends MealPlanEvent {
  final String weekKey;
  final List<FavoriteRecipeModel> favoriteRecipes;

  const SaveMealPlanEvent(
      {required this.weekKey, required this.favoriteRecipes});

  @override
  List<Object?> get props => [weekKey, favoriteRecipes];
}

class DeleteMealPlanEvent extends MealPlanEvent {
  final String id;

  const DeleteMealPlanEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddFavoritesMealPlanEvent extends MealPlanEvent {
  final String recipeId;

  const AddFavoritesMealPlanEvent(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}
