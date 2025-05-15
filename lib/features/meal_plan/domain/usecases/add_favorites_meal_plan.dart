import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class AddFavoritesMealPlan {
  final MealPlanRepository repository;

  AddFavoritesMealPlan({required this.repository});

  Future<void> call(String weekKey, List<FavoriteRecipeModel> newRecipes) {
    return repository.addFavoritesMealPlan(weekKey, newRecipes);
  }
}
