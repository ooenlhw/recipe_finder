import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';

class GetRecipeById {
  final RecipeRepository repository;

  GetRecipeById({required this.repository});

  Future<Either<Failure, RecipeModel>> call(String id) {
    return repository.getRecipeById(id);
  }
}
