part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent {}

class FetchRecipeByIdEvent extends RecipeDetailEvent {
  final String id;

  FetchRecipeByIdEvent(this.id);
}
