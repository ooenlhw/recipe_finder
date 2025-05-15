import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';

class GetRecipeById {
  final RecipeRepository repository;

  GetRecipeById({required this.repository});

  Future<List<RecipeModel>> call(String ingredients) {
    return repository.getRecipeById(ingredients);
  }
}
