import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';

abstract class MealPlanRepository {
  Future<Map<String, List<int>>> loadMealPlans();
  Future<void> saveMealPlan(String weekKey, List<FavoriteRecipeModel> favoriteRecipes);
  Future<void> deleteMealPlan(String weekKey);
  Future<void> addFavoritesMealPlan(String weekKey, List<int> recipeIds);
}
