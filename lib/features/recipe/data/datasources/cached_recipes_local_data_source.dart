// import 'dart:convert';

// import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// abstract class CachedRecipesLocalDataSource {
//   Future<void> cacheRecipes(List<RecipeModel> recipes);
//   Future<List<RecipeModel>> getCachedRecipes();
//   Future<bool> isCacheValid();
// }

// class CachedRecipesLocalDataSourceImpl implements CachedRecipesLocalDataSource {
//   final SharedPreferences sharedPreferences;
//   static const String cacheKey = 'cached_recipes';
//   static const String timestampKey = 'cached_recipes_timestamp';

//   CachedRecipesLocalDataSourceImpl({required this.sharedPreferences});

//   @override
//   Future<void> cacheRecipes(List<RecipeModel> recipes) async {
//     final jsonString = json.encode(recipes.map((e) => e.toJson()).toList());
//     await sharedPreferences.setString(cacheKey, jsonString);
//     await sharedPreferences.setInt(
//         timestampKey, DateTime.now().millisecondsSinceEpoch);
//   }

//   @override
//   Future<List<RecipeModel>> getCachedRecipes() async {
//     final jsonString = sharedPreferences.getString(cacheKey);
//     if (jsonString != null) {
//       final List<dynamic> decoded = json.decode(jsonString);
//       return decoded.map((e) => RecipeModel.fromJson(e)).toList();
//     }
//     return [];
//   }

//   Future<bool> isCacheValid() async {
//     final timestamp = sharedPreferences.getInt(timestampKey);
//     if (timestamp == null) return false;

//     final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
//     return DateTime.now().difference(cachedTime).inMinutes < 30;
//   }
// }
