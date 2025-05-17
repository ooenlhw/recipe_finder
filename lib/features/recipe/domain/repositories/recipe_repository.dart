import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> getRecipesByIngredients(
      String ingredients);
  Future<Either<Failure, RecipeModel>> getRecipeById(String id);
}
