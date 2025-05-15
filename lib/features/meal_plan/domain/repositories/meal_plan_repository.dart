import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';

abstract class MealPlanRepository {
  Future<Map<String, List<MealPlanModel>>> loadMealPlans();
  Future<void> saveMealPlan(
      String weekKey, List<FavoriteRecipeModel> favoriteRecipes);
  Future<void> deleteMealPlan(String weekKey);
  Future<void> addFavoritesMealPlan(
      String weekKey, List<FavoriteRecipeModel> recipes);
}
