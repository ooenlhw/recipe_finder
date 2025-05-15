import 'package:recipe_finder/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavorite({required this.repository});

  Future<void> call(int id) {
    return repository.removeFavorite(id);
  }
}
