part of 'recipe_list_bloc.dart';

abstract class RecipeListEvent {}

class FetchRecipesByIngredientsEvent extends RecipeListEvent {
  final String ingredients;

  FetchRecipesByIngredientsEvent(this.ingredients);
}
