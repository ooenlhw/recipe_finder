import 'dart:convert';

import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedFavoritesKey = 'CACHED_FAVORITES';

abstract class FavoritesLocalDataSource {
  Future<void> cacheFavorite(FavoriteRecipeModel recipe);
  Future<void> removeFavorite(int id);
  Future<List<FavoriteRecipeModel>> getCachedFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;
  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheFavorite(FavoriteRecipeModel recipe) async {
    final favorites = await getCachedFavorites();
    final updatedFavorites = [
      ...favorites.where((fav) => fav.id != recipe.id),
      recipe
    ];

    final jsonList = updatedFavorites.map((r) => r.toJson()).toList();
    await sharedPreferences.setString(
        cachedFavoritesKey, json.encode(jsonList));
  }

  @override
  Future<List<FavoriteRecipeModel>> getCachedFavorites() async {
    final jsonString = sharedPreferences.getString(cachedFavoritesKey);
    if (jsonString != null) {
      final jsonList = json.decode(jsonString) as List;
      return jsonList.map((r) => FavoriteRecipeModel.fromJson(r)).toList();
    }
    return [];
  }

  @override
  Future<void> removeFavorite(int id) async {
    final favorites = await getCachedFavorites();
    final updatedFavorites =
        favorites.where((recipe) => recipe.id != id).toList();
    final jsonList = updatedFavorites.map((r) => r.toJson()).toList();
    await sharedPreferences.setString(
        cachedFavoritesKey, json.encode(jsonList));
  }
}
