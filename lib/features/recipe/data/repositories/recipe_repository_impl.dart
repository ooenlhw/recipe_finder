import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/core/network/network_checker.dart';
import 'package:recipe_finder/features/recipe/data/datasources/cached_recipes_local_data_source.dart';
import 'package:recipe_finder/features/recipe/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipe/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource recipeRemoteDataSource;
  final CachedRecipesLocalDataSource cachedRecipesLocalDataSource;

  RecipeRepositoryImpl(
      {required this.recipeRemoteDataSource,
      required this.cachedRecipesLocalDataSource});

  @override
  Future<Either<Failure, List<RecipeModel>>> getRecipesByIngredients(
      String ingredients) async {
    try {
      final isOnline = await NetworkChecker.isOnline();

      if (!isOnline) {
        // No internet, return cached data if available
        final cached =
            await cachedRecipesLocalDataSource.getCachedRecipes(ingredients);
        if (cached.isNotEmpty)
          return Right(cached);
        else
          return Left(ServerFailure('No internet and no cached data'));
      }

      // Online, check if cache is valid
      final isValid =
          await cachedRecipesLocalDataSource.isCacheValid(ingredients);
      if (isValid) {
        final cached =
            await cachedRecipesLocalDataSource.getCachedRecipes(ingredients);
        return Right(cached);
      }

      // Cache invalid or empty, fetch remote and update cache
      final remoteRecipes =
          await recipeRemoteDataSource.getRecipesByIngredients(ingredients);
      await cachedRecipesLocalDataSource.cacheRecipes(
          ingredients, remoteRecipes);
      return Right(remoteRecipes);
    } catch (_) {
      // If any error happens, fallback to cached data if possible
      final fallback =
          await cachedRecipesLocalDataSource.getCachedRecipes(ingredients);
      if (fallback.isNotEmpty) {
        return Right(fallback);
      } else {
        return Left(ServerFailure('An error occurred while fetching recipes.'));
      }
    }
  }

  @override
  Future<Either<Failure, RecipeModel>> getRecipeById(String id) async {
    try {
      final isOnline = await NetworkChecker.isOnline();

      if (!isOnline) {
        // No internet, return cached recipe if available
        final cachedRecipe =
            await cachedRecipesLocalDataSource.getCachedRecipeById(id);
        print('cachedRecipe Detail by $id: $cachedRecipe');
        if (cachedRecipe != null) {
          return Right(cachedRecipe);
        } else {
          return Left(
              ServerFailure('No internet and no cached data for this recipe'));
        }
      }

      // Online, check if cache is valid for this recipe
      final isValid =
          await cachedRecipesLocalDataSource.isCacheValidForRecipe(id);
      if (isValid) {
        final cachedRecipe =
            await cachedRecipesLocalDataSource.getCachedRecipeById(id);
        if (cachedRecipe != null) {
          return Right(cachedRecipe);
        }
      }

      // Cache invalid or missing, fetch remote and cache it
      final remoteRecipe = await recipeRemoteDataSource.getRecipeById(id);
      print('remoteRecipe before caching by $id: $remoteRecipe');
      await cachedRecipesLocalDataSource.cacheRecipeById(id, remoteRecipe);
      return Right(remoteRecipe);
    } catch (_) {
      // On error, fallback to cache if available
      final fallback =
          await cachedRecipesLocalDataSource.getCachedRecipeById(id);
      if (fallback != null) {
        return Right(fallback);
      } else {
        return Left(
            ServerFailure('An error occurred while fetching recipe details.'));
      }
    }
  }
}
