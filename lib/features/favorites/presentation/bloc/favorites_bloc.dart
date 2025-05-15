import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/remove_favorite.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorites getFavorites;

  FavoritesBloc({
    required this.addFavorite,
    required this.removeFavorite,
    required this.getFavorites,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      final favorites = await getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: $e'));
    }
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (!isClosed) {
      try {
        
        await addFavorite(event.recipe);
        add(LoadFavorites()); // reload updated list
      } catch (e) {
        emit(FavoritesError('Failed to add to favorites'));
      }
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (!isClosed) {
      try {
        await removeFavorite(event.id);
        add(LoadFavorites()); // reload updated list
      } catch (e) {
        emit(FavoritesError('Failed to remove from favorites'));
      }
    }
  }
}
