import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorites_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;

  GetFavorites({required this.repository});

  Future<List<FavoriteRecipeModel>> call() {
    return repository.getFavorites();
  }
}
