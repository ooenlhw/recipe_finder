import 'package:recipe_finder/features/recipe/data/models/ingredient_model.dart';

class RecipeEntity {
  final int id;
  final String title;
  final String image;
  final int likes;
  final int readyInMinutes;
  final int servings;
  final String summary;
  final String instructions;
  final int usedIngredientCount;
  final int missedIngredientCount;
  final List<IngredientModel> extendedIngredients;
  final List<IngredientModel> usedIngredients;
  final List<IngredientModel> missedIngredients;

  const RecipeEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.likes,
    required this.readyInMinutes,
    required this.servings,
    required this.summary,
    required this.instructions,
    required this.usedIngredientCount,
    required this.missedIngredientCount,
    required this.extendedIngredients,
    required this.usedIngredients,
    required this.missedIngredients,
  });
}
