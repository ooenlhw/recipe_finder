import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipesByIngredients(String ingredients);
  Future<RecipeModel> getRecipeById(String id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;
  final String? apiKey = 'ac3e9ea96cc344cda6d6d648fbcd1360'; // username: won
  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> getRecipesByIngredients(String ingredients) async {
    print('ingredients to search: $ingredients');
    final response = await client.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&apiKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => RecipeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes by ingredients');
    }
  }

  @override
  Future<RecipeModel> getRecipeById(String id) async {
    final response = await client.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return RecipeModel.fromJson(json);
    } else {
      throw Exception('Failed to load recipe by id');
    }
  }
}
