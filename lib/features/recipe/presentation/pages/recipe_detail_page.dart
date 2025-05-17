import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_finder/core/widgets/network_sensitive_widget.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe_entity.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipe/presentation/bloc/recipe_detail_bloc.dart';

class RecipeDetailPage extends StatefulWidget {
  final String id;
  final RecipeRepository recipeRepository;

  const RecipeDetailPage(
      {super.key, required this.id, required this.recipeRepository});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  RecipeEntity? recipe;
  bool isOnline = false;

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavorites());
    context.read<RecipeDetailBloc>().add(FetchRecipeByIdEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return
        // NetworkSensitiveWidget(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text('Recipe Detail',
            style: Theme.of(context).textTheme.headlineLarge),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            bool isFav = false;
            if (state is FavoritesLoaded) {
              isFav = state.favorites.any((fav) => fav.id == widget.id);
            }
            return BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
              builder: (context, state) {
                if (state is RecipeDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecipeDetailError) {
                  return Center(child: Text(state.message));
                } else if (state is RecipeDetailLoaded) {
                  recipe = state.recipe;
                  return RecipeDetail(context, recipe!, isFav);
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
    // );
  }

  Widget RecipeDetail(BuildContext context, RecipeEntity recipe, bool isFav) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    (kIsWeb)
                        ? const SizedBox.shrink()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              recipe.image,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, _) =>
                                  const SizedBox(
                                      height: 200,
                                      child: Center(
                                          child:
                                              Icon(Icons.image_not_supported))),
                            ),
                          ),
                    const SizedBox(height: 16),
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ready in ${recipe.readyInMinutes} minutes',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Servings: ${recipe.servings}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Instructions:',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.instructions,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ingredients:',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.extendedIngredients
                          .map((ingredient) => '- ${ingredient.name}')
                          .join('\n'),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _toggleFavorite(context, isFav),
            tooltip: isFav ? 'Remove from favorites' : 'Save as favorite',
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite(BuildContext context, bool isFav) {
    final bloc = context.read<FavoritesBloc>();

    final recipe = this.recipe;
    if (recipe == null) return;

    final favoriteRecipe = FavoriteRecipeModel(
      id: recipe.id,
      title: recipe.title,
      image: recipe.image,
      readyInMinutes: recipe.readyInMinutes,
      servings: recipe.servings,
      instructions: recipe.instructions,
      extendedIngredients: recipe.extendedIngredients,
      usedIngredients: recipe.usedIngredients,
      missedIngredients: recipe.missedIngredients,
      usedIngredientCount: recipe.usedIngredientCount,
      missedIngredientCount: recipe.missedIngredientCount,
      likes: recipe.likes,
      summary: recipe.summary,
    );

    if (isFav) {
      bloc.add(RemoveFromFavorites(favoriteRecipe.id));
      _showSnackBar(context, 'Removed from favorites');
    } else {
      bloc.add(AddToFavorites(favoriteRecipe));
      _showSnackBar(context, 'Added to favorites');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
