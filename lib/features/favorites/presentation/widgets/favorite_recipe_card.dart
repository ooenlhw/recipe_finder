import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';

class FavoriteRecipeCard extends StatelessWidget {
  final FavoriteRecipeModel recipe;

  const FavoriteRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Image.network(
          recipe.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.image),
        ),
        title: Text(recipe.title),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<FavoritesBloc>().add(RemoveFromFavorites(recipe.id));
          },
        ),
        onTap: () {
          context.push('/recipes/${recipe.id}');
        },
      ),
    );
  }
}
