import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(FavoriteRecipeModel recipe);
  Future<void> removeFavorite(int id);
  Future<List<FavoriteRecipeModel>> getFavorites();
}
