import 'dart:convert';

import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CachedRecipesLocalDataSource {
  Future<void> cacheRecipes(String qurey, List<RecipeModel> recipes);
  Future<List<RecipeModel>> getCachedRecipes(String query);
  Future<bool> isCacheValid(String query);

  Future<void> cacheRecipeById(String id, RecipeModel recipe);
  Future<RecipeModel?> getCachedRecipeById(String id);
  Future<bool> isCacheValidForRecipe(String id);
}

class CachedRecipesLocalDataSourceImpl implements CachedRecipesLocalDataSource {
  final SharedPreferences sharedPreferences;

  CachedRecipesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheRecipes(String query, List<RecipeModel> recipes) async {
    final key = 'cache_$query';
    final timestampKey = 'cache_time_$query';
    final jsonString = json.encode(recipes.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(key, jsonString);
    await sharedPreferences.setInt(
        timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<List<RecipeModel>> getCachedRecipes(String query) async {
    final key = 'cache_$query';
    final jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.map((e) => RecipeModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<bool> isCacheValid(String query) async {
    final timestampKey = 'cache_time_$query';
    final timestamp = sharedPreferences.getInt(timestampKey);
    if (timestamp == null) return false;

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cachedTime).inMinutes < 30;
  }

  // Cache single recipe
  @override
  Future<void> cacheRecipeById(String id, RecipeModel recipe) async {
    final key = 'cache_recipe_$id';
    final timestampKey = 'cache_recipe_time_$id';
    final jsonString = json.encode(recipe.toJson());
    await sharedPreferences.setString(key, jsonString);
    await sharedPreferences.setInt(
        timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Get single cached recipe by id
  @override
  Future<RecipeModel?> getCachedRecipeById(String id) async {
    final key = 'cache_recipe_$id';
    final jsonString = sharedPreferences.getString(key);
    print('getCachedRecipeById jsonString: $jsonString');
    if (jsonString != null) {
      final decoded = json.decode(jsonString);
      return RecipeModel.fromJson(decoded);
    }
    return null;
  }

  // Check if cache for single recipe is valid
  @override
  Future<bool> isCacheValidForRecipe(String id) async {
    final timestampKey = 'cache_recipe_time_$id';
    final timestamp = sharedPreferences.getInt(timestampKey);
    if (timestamp == null) return false;

    final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(cachedTime).inMinutes < 30;
  }
}
