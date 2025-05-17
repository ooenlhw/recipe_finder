part of 'recipe_list_bloc.dart';

abstract class RecipeListState {}

class RecipeListInitial extends RecipeListState {}

class RecipeListLoading extends RecipeListState {}

class RecipeListLoaded extends RecipeListState {
  final List<RecipeEntity> recipes;

  RecipeListLoaded(this.recipes);
}

class RecipeListError extends RecipeListState {
  final String message;

  RecipeListError(this.message);
}