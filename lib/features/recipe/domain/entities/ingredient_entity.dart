class IngredientEntity {
  final int id;
  final String name;
  final double amount;
  final String unit;
  final String original;
  final String imageUrl;

  const IngredientEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
    required this.original,
    required this.imageUrl,
  });

  factory IngredientEntity.fromJson(Map<String, dynamic> json) {
    return IngredientEntity(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      unit: json['unit'],
      original: json['original'],
      imageUrl: json['image'],
    );
  }
}
