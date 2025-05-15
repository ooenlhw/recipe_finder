import 'dart:convert';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MealPlanLocalDataSource {
  Future<Map<String, List<MealPlanModel>>> loadMealPlans();
  Future<void> saveMealPlan(
      String weekKey, List<FavoriteRecipeModel> favoriteRecipes);
  Future<void> deleteMealPlan(String weekKey);
  Future<void> addFavoritesMealPlan(
      String weekKey, List<FavoriteRecipeModel> newRecipes);
}

const CACHED_MEAL_PLANS = 'CACHED_MEAL_PLANS';

class MealPlanLocalDataSourceImpl implements MealPlanLocalDataSource {
  final SharedPreferences sharedPreferences;

  MealPlanLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Map<String, List<MealPlanModel>>> loadMealPlans() async {
    final jsonString = sharedPreferences.getString(CACHED_MEAL_PLANS);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return jsonMap.map((key, value) {
        final list = (value as List)
            .map((e) => MealPlanModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return MapEntry(key, list);
      });
    }
    return {};
  }

  @override
  Future<void> saveMealPlan(
      String weekKey, List<FavoriteRecipeModel> favoriteRecipes) async {
    final plans = await loadMealPlans();
    plans[weekKey] = [
      MealPlanModel(
          id: weekKey, recipes: favoriteRecipes, createdAt: DateTime.now())
    ];
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
      String weekKey, List<FavoriteRecipeModel> newRecipes) async {
    final plans = await loadMealPlans();
    plans[weekKey] = [
      ...plans[weekKey]!,
      ...newRecipes
          .map((recipe) => MealPlanModel(
              id: weekKey, recipes: newRecipes, createdAt: DateTime.now()))
          .toList()
    ];
    await _cacheMealPlans(plans);
  }

  Future<void> _cacheMealPlans(Map<String, List<MealPlanModel>> plans) async {
    final jsonString = json.encode(plans.map(
        (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList())));
    await sharedPreferences.setString(CACHED_MEAL_PLANS, jsonString);
  }
}
