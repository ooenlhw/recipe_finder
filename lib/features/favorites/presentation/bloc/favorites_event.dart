part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final FavoriteRecipeModel recipe;

  AddToFavorites(this.recipe);
}

class RemoveFromFavorites extends FavoritesEvent {
  final int id;

  RemoveFromFavorites(this.id);
}
