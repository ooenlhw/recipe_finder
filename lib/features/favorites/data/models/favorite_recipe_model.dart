import 'package:recipe_finder/features/recipe/data/models/ingredient_model.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';

class FavoriteRecipeModel extends RecipeModel {
  FavoriteRecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.readyInMinutes,
    required super.servings,
    required super.summary,
    required super.instructions,
    required super.likes,
    required super.usedIngredientCount,
    required super.missedIngredientCount,
    required super.extendedIngredients,
    required super.usedIngredients,
    required super.missedIngredients,
  });

  factory FavoriteRecipeModel.fromJson(Map<String, dynamic> json) {
    return FavoriteRecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      summary: json['summary'],
      instructions: json['instructions'],
      likes: json['likes'],
      usedIngredientCount: json['usedIngredientCount'],
      missedIngredientCount: json['missedIngredientCount'],
      extendedIngredients: (json['extendedIngredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
      usedIngredients: (json['usedIngredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
      missedIngredients: (json['missedIngredients'] as List)
          .map((e) => IngredientModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'summary': summary,
      'instructions': instructions,
      'likes': likes,
      'usedIngredientCount': usedIngredientCount,
      'missedIngredientCount': missedIngredientCount,
      'extendedIngredients': extendedIngredients,
      'usedIngredients': usedIngredients,
      'missedIngredients': missedIngredients,
    };
  }

  List<Object?> get props => [id];
}
