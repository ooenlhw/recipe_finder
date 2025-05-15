part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

class RecipeInitialState extends RecipeState {}

class RecipeLoadingState extends RecipeState {
  const RecipeLoadingState();

  @override
  List<Object?> get props => [];
}

class RecipeLoadedState extends RecipeState {
  final List<RecipeModel> recipes;

  const RecipeLoadedState(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class RecipeErrorState extends RecipeState {
  final String message;

  const RecipeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
