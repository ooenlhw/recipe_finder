import 'package:recipe_finder/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource favoritesLocalDataSource;

  FavoritesRepositoryImpl({required this.favoritesLocalDataSource});

  @override
  Future<List<FavoriteRecipeModel>> getFavorites() async {
    final models = await favoritesLocalDataSource.getCachedFavorites();
    return models.map((model) => model).toList();
  }

  @override
  Future<void> addFavorite(FavoriteRecipeModel recipe) async {
    final model = FavoriteRecipeModel(
      id: recipe.id,
      title: recipe.title,
      image: recipe.image,
      readyInMinutes: recipe.readyInMinutes,
      servings: recipe.servings,
      summary: recipe.summary,
      instructions: recipe.instructions,
      likes: recipe.likes,
      usedIngredientCount: recipe.usedIngredientCount,
      missedIngredientCount: recipe.missedIngredientCount,
      extendedIngredients: recipe.extendedIngredients,
      usedIngredients: recipe.usedIngredients,
      missedIngredients: recipe.missedIngredients,
    );
    await favoritesLocalDataSource.cacheFavorite(model);
  }

  @override
  Future<void> removeFavorite(int id) async {
    await favoritesLocalDataSource.removeFavorite(id);
  }
}
