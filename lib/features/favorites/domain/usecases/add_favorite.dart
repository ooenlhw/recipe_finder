import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorites_repository.dart';

class AddFavorite {
  final FavoritesRepository repository;

  AddFavorite({required this.repository});

  Future<void> call(FavoriteRecipeModel recipe) {
    return repository.addFavorite(recipe);
  }
}
