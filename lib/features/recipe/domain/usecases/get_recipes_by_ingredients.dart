import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe_entity.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';

class GetRecipesByIngredients {
  final RecipeRepository repository;

  GetRecipesByIngredients({required this.repository});

  Future<Either<Failure, List<RecipeEntity>>> call(String ingredients) {
    return repository.getRecipesByIngredients(ingredients);
  }
}
