import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';

class MealPlanModel {
  final String id;
  final List<FavoriteRecipeModel> recipes;
  final DateTime createdAt;

  MealPlanModel({
    required this.id,
    required this.recipes,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipes': recipes.map((e) => e.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    return MealPlanModel(
      id: json['id'],
      recipes: (json['recipes'] as List)
          .map((e) => FavoriteRecipeModel.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
