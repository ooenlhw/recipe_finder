import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/meal_plan/data/datasources/meal_plan_local_data_source.dart';
import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class MealPlanRepositoryImpl implements MealPlanRepository {
  final MealPlanLocalDataSource mealPlanLocalDataSource;

  MealPlanRepositoryImpl({required this.mealPlanLocalDataSource});

  @override
  Future<Map<String, List<MealPlanModel>>> loadMealPlans() {
    return mealPlanLocalDataSource.loadMealPlans();
  }

  @override
  Future<void> saveMealPlan(
      String weekKey, List<FavoriteRecipeModel> favoriteRecipes) {
    return mealPlanLocalDataSource.saveMealPlan(weekKey, favoriteRecipes);
  }

  @override
  Future<void> deleteMealPlan(String weekKey) {
    return mealPlanLocalDataSource.deleteMealPlan(weekKey);
  }

  @override
  Future<void> addFavoritesMealPlan(
      String weekKey, List<FavoriteRecipeModel> recipes) {
    return mealPlanLocalDataSource.addFavoritesMealPlan(weekKey, recipes);
  }
}
