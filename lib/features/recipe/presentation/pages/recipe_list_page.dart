import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_finder/core/network/network_checker.dart';
import 'package:recipe_finder/core/widgets/network_sensitive_widget.dart';
import 'package:recipe_finder/features/recipe/presentation/bloc/recipe_list_bloc.dart';
import 'package:recipe_finder/features/recipe/presentation/widgets/no_recipes_found.dart';
import 'package:recipe_finder/features/recipe/presentation/widgets/recipe_card.dart';

class RecipeListPage extends StatefulWidget {
  final String ingredients;

  const RecipeListPage({super.key, required this.ingredients});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  late RecipeListBloc _recipeListBloc;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    _checkNetwork();
    _recipeListBloc = context.read<RecipeListBloc>();
    print('recipestate: ${_recipeListBloc.state}');
    _recipeListBloc.add(FetchRecipesByIngredientsEvent(widget.ingredients));
  }

  Future<void> _checkNetwork() async {
    final online = await NetworkChecker.isOnline();
    if (!online) {
      setState(() => isOffline = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // NetworkSensitiveWidget(
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text("Recipes for '${widget.ingredients}'",
            style: Theme.of(context).textTheme.headlineLarge),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<RecipeListBloc, RecipeListState>(
        bloc: _recipeListBloc,
        builder: (context, state) {
          if (state is RecipeListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecipeListLoaded) {
            final recipes = state.recipes;
            if (recipes.isEmpty) {
              return const Center(child: NoRecipesFound());
            }
            // Display recipes in 2-column layout using ListView
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: (recipes.length / 2).ceil(),
              itemBuilder: (context, index) {
                final int firstIndex = index * 2;
                final int secondIndex = index * 2 + 1;
                return Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 350,
                        child: RecipeCard(
                          recipe: recipes[firstIndex],
                          onTap: () => GoRouter.of(context)
                              .push('/recipes/${recipes[firstIndex].id}'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    if (secondIndex < recipes.length)
                      Expanded(
                        child: SizedBox(
                          height: 350,
                          child: RecipeCard(
                            recipe: recipes[secondIndex],
                            onTap: () => GoRouter.of(context)
                                .push('/recipes/${recipes[secondIndex].id}'),
                          ),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()), // empty for alignment
                  ],
                );
              },
            );
          } else if (state is RecipeListError) {
            return Center(child: Text(state.message));
          } else {
            print('Recipe state shrink: $state');
            return const SizedBox.shrink();
          }
        },
      ),
    );
    // );
  }
}
