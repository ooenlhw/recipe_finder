import 'package:equatable/equatable.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';

class MealPlanEntity extends Equatable {
  final String id; // UUID or timestamp-based unique ID
  final String title; // e.g., "Week of May 13–19"
  final List<FavoriteRecipeModel> recipes;
  final DateTime createdAt;

  const MealPlanEntity({
    required this.id,
    required this.title,
    required this.recipes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, recipes, createdAt];
}
