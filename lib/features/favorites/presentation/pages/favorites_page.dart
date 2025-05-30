import 'package:flutter/material.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder/features/favorites/presentation/widgets/favorite_recipe_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/service_locator.dart' as di;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesBloc(
        addFavorite: di.sl(),
        getFavorites: di.sl(),
        removeFavorite: di.sl(),
      )..add(LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorite Recipes',
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return const Center(child: Text('No favorite recipes yet.'));
              }
              return ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final recipe = state.favorites[index];
                  print("favorite recipe card: ${recipe.toJson()}");
                  return FavoriteRecipeCard(recipe: recipe);
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
