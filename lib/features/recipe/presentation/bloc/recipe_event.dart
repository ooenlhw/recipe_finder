part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class FetchRecipesByIngredientsEvent extends RecipeEvent {
  final String ingredients;

  const FetchRecipesByIngredientsEvent(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}

class FetchRecipeByIdEvent extends RecipeEvent {
  final String id;

  const FetchRecipeByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}