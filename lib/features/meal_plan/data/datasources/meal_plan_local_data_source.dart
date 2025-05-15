import 'dart:convert';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MealPlanLocalDataSource {
  Future<Map<String, List<int>>> loadMealPlans();
  Future<void> saveMealPlan(
      String weekKey, List<FavoriteRecipeModel> favoriteRecipes);
  Future<void> deleteMealPlan(String weekKey);
  Future<void> addFavoritesMealPlan(String weekKey, List<int> newRecipeIds);
}

const CACHED_MEAL_PLANS = 'CACHED_MEAL_PLANS';

class MealPlanLocalDataSourceImpl implements MealPlanLocalDataSource {
  final SharedPreferences sharedPreferences;

  MealPlanLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Map<String, List<int>>> loadMealPlans() async {
    final jsonString = sharedPreferences.getString(CACHED_MEAL_PLANS);
    if (jsonString != null) {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(key, List<int>.from(value)));
    }
    return {};
  }

  @override
  Future<void> saveMealPlan(
      String weekKey, List<FavoriteRecipeModel> favoriteRecipes) async {
    final plans = await loadMealPlans();
    plans[weekKey] = favoriteRecipes.map((e) => e.id).toList();
    await _cacheMealPlans(plans);
  }

  @override
  Future<void> deleteMealPlan(String weekKey) async {
    final plans = await loadMealPlans();
    plans.remove(weekKey);
    await _cacheMealPlans(plans);
  }

  @override
  Future<void> addFavoritesMealPlan(
      String weekKey, List<int> newRecipeIds) async {
    final plans = await loadMealPlans();
    final current = plans[weekKey] ?? [];
    final updated =
        [...current, ...newRecipeIds].toSet().toList(); // deduplicated
    plans[weekKey] = updated;
    await _cacheMealPlans(plans);
  }

  Future<void> _cacheMealPlans(Map<String, List<int>> plans) async {
    final jsonString = json.encode(plans);
    await sharedPreferences.setString(CACHED_MEAL_PLANS, jsonString);
  }
}
