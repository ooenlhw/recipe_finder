import 'package:recipe_finder/features/recipe/domain/entities/recipe_entity.dart';

import 'ingredient_model.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel({
    required super.id,
    required super.title,
    required super.image,
    required super.likes,
    required super.readyInMinutes,
    required super.servings,
    required super.summary,
    required super.instructions,
    required super.usedIngredientCount,
    required super.missedIngredientCount,
    required List<IngredientModel> super.extendedIngredients,
    required List<IngredientModel> super.usedIngredients,
    required List<IngredientModel> super.missedIngredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      image: json['image'] ?? '',
      likes: json['likes'] ?? 0,
      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      summary: json['summary'] ?? '',
      instructions: json['instructions'] ?? '',
      usedIngredientCount: json['usedIngredientCount'] ?? 0,
      missedIngredientCount: json['missedIngredientCount'] ?? 0,
      extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
              ?.map((e) => IngredientModel.fromJson(e))
              .toList() ??
          [],
      usedIngredients: (json['usedIngredients'] as List<dynamic>?)
              ?.map((e) => IngredientModel.fromJson(e))
              .toList() ??
          [],
      missedIngredients: (json['missedIngredients'] as List<dynamic>?)
              ?.map((e) => IngredientModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'likes': likes,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'summary': summary,
      'instructions': instructions,
      'usedIngredientCount': usedIngredientCount,
      'missedIngredientCount': missedIngredientCount,
      'extendedIngredients': extendedIngredients
          .map((ingredient) => (ingredient).toJson())
          .toList(),
      'usedIngredients':
          usedIngredients.map((ingredient) => (ingredient).toJson()).toList(),
      'missedIngredients':
          missedIngredients.map((ingredient) => (ingredient).toJson()).toList(),
    };
  }
}
