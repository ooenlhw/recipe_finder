import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_finder/core/widgets/main_tab_scaffold.dart';
import 'package:recipe_finder/features/favorites/presentation/pages/favorites_page.dart';
import 'package:recipe_finder/features/meal_plan/presentation/pages/meal_plan_page.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipe/presentation/pages/ingredient_search_page.dart';
import 'package:recipe_finder/features/recipe/presentation/pages/recipe_detail_page.dart';
import 'package:recipe_finder/features/recipe/presentation/pages/recipe_list_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
GoRouter createRouter({required RecipeRepository recipeRepository}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/search',
    routes: [
      // ShellRoute for bottom tab scaffold
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainTabScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/search',
            pageBuilder: (_, __) => NoTransitionPage(
              child: IngredientSearchPage(),
            ),
          ),
          GoRoute(
            path: '/favorites',
            pageBuilder: (_, __) => NoTransitionPage(
              child: FavoritesPage(),
            ),
          ),
          GoRoute(
            path: '/meal-plan',
            pageBuilder: (_, __) => NoTransitionPage(
              child: MealPlanPage(),
            ),
          ),
        ],
      ),
      // Non-tab routes (e.g. detail pages)
      GoRoute(
        path: '/recipes/search/:ingredients',
        pageBuilder: (_, state) {
          final ingredients = state.pathParameters['ingredients']!;
          return NoTransitionPage(
            child: RecipeListPage(ingredients: ingredients),
          );
        },
      ),
      GoRoute(
        path: '/recipes',
        builder: (context, state) => RecipeListPage(
            ingredients: state.pathParameters['ingredients'] ?? ''),
      ),
      GoRoute(
        path: '/recipes/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RecipeDetailPage(
            id: id,
            recipeRepository: recipeRepository,
          );
        },
      ),
      // other routes ...
    ],
  );
}
