import 'package:recipe_finder/core/error/failures.dart';
// import 'package:recipe_finder/features/recipe/data/datasources/cached_recipes_local_data_source.dart';
import 'package:recipe_finder/features/recipe/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource recipeRemoteDataSource;
  // final CachedRecipesLocalDataSource cachedRecipesLocalDataSource;

  RecipeRepositoryImpl({
    required this.recipeRemoteDataSource,
    // required this.cachedRecipesLocalDataSource
  });

  @override
  Future<Either<Failure, List<RecipeModel>>> getRecipesByIngredients(
      String ingredients) async {
    try {
      // final isValid = await cachedRecipesLocalDataSource.isCacheValid();
      // if (isValid) {
      //   final cached = await cachedRecipesLocalDataSource.getCachedRecipes();
      //   return Right(cached);
      // }

      final remoteRecipes =
          await recipeRemoteDataSource.getRecipesByIngredients(ingredients);
      // await cachedRecipesLocalDataSource.cacheRecipes(remoteRecipes);
      return Right(remoteRecipes);
    } catch (_) {
      // final fallback = await cachedRecipesLocalDataSource.getCachedRecipes();
      // if (fallback.isNotEmpty) {
      //   return Right(fallback);
      // } else {
      return Left(ServerFailure('An error occurred while fetching recipes.'));
      // }
    }
  }

  @override
  Future<List<RecipeModel>> getRecipeById(String id) {
    return recipeRemoteDataSource.getRecipeById(id);
  }
}
