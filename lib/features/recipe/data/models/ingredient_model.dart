import 'package:recipe_finder/features/recipe/domain/entities/ingredient_entity.dart';

class IngredientModel extends IngredientEntity {
  const IngredientModel({
    required super.id,
    required super.name,
    required super.amount,
    required super.unit,
    required super.original,
    required super.imageUrl,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
      amount: (json['amount'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      original: json['original'] ?? '',
      imageUrl: json['image'] != null
          ? 'https://img.spoonacular.com/ingredients_100x100/${json['image']}'
          : '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
        'unit': unit,
        'original': original,
        'image': imageUrl.replaceAll(
            'https://img.spoonacular.com/ingredients_100x100/', ''),
      };
}
