import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_finder/core/routing/router.dart';
import 'package:recipe_finder/core/theme.dart';
import 'package:recipe_finder/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:recipe_finder/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/add_favorite.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/get_favorites.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder/features/meal_plan/data/datasources/meal_plan_local_data_source.dart';
import 'package:recipe_finder/features/meal_plan/data/repositories/meal_plan_repository_impl.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/delete_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/load_meal_plans.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/add_favorites_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/save_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import 'package:recipe_finder/features/recipe/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_finder/features/recipe/domain/usecases/get_recipe_by_id.dart';
import 'package:recipe_finder/features/recipe/domain/usecases/get_recipes_by_ingredients.dart';
import 'package:recipe_finder/features/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_finder/features/recipe/presentation/pages/ingredient_search_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final recipeRemoteDataSource = RecipeRemoteDataSourceImpl(
    client: http.Client(),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  // final cachedRecipesLocalDataSource = CachedRecipesLocalDataSourceImpl(
  //   sharedPreferences: await SharedPreferences.getInstance(),
  // );
  final favoritesLocalDataSource = FavoritesLocalDataSourceImpl(
    sharedPreferences: sharedPreferences,
  );
  final mealPlanLocalDataSource = MealPlanLocalDataSourceImpl(
    sharedPreferences: sharedPreferences,
  );
  final recipeRepository = RecipeRepositoryImpl(
    recipeRemoteDataSource: recipeRemoteDataSource,
    // cachedRecipesLocalDataSource: cachedRecipesLocalDataSource,
  );
  final favoritesRepository = FavoritesRepositoryImpl(
    favoritesLocalDataSource: favoritesLocalDataSource,
  );
  final mealPlanRepository = MealPlanRepositoryImpl(
    mealPlanLocalDataSource: mealPlanLocalDataSource,
  );
  final getRecipesByIngredients = GetRecipesByIngredients(
    repository: recipeRepository,
  );
  final getRecipeById = GetRecipeById(
    repository: recipeRepository,
  );
  final addFavorite = AddFavorite(
    repository: favoritesRepository,
  );
  final getFavorites = GetFavorites(
    repository: favoritesRepository,
  );
  final removeFavorite = RemoveFavorite(
    repository: favoritesRepository,
  );
  final loadMealPlans = LoadMealPlans(repository: mealPlanRepository);
  final saveMealPlan = SaveMealPlan(repository: mealPlanRepository);
  final deleteMealPlan = DeleteMealPlan(repository: mealPlanRepository);
  final addFavoritesMealPlan =
      AddFavoritesMealPlan(repository: mealPlanRepository);
  runApp(
    MultiBlocProvider(
      providers: [
        Provider<GetRecipesByIngredients>.value(value: getRecipesByIngredients),
        Provider<GetRecipeById>.value(value: getRecipeById),
        Provider<AddFavorite>.value(value: addFavorite),
        Provider<GetFavorites>.value(value: getFavorites),
        Provider<RemoveFavorite>.value(value: removeFavorite),
        Provider<LoadMealPlans>.value(value: loadMealPlans),
        Provider<SaveMealPlan>.value(value: saveMealPlan),
        Provider<DeleteMealPlan>.value(value: deleteMealPlan),
        Provider<AddFavoritesMealPlan>.value(value: addFavoritesMealPlan),
        BlocProvider<RecipeBloc>(
          create: (context) => RecipeBloc(
            getRecipesByIngredients: context.read<GetRecipesByIngredients>(),
            getRecipeById: context.read<GetRecipeById>(),
          ),
          child: IngredientSearchPage(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            addFavorite: context.read<AddFavorite>(),
            getFavorites: context.read<GetFavorites>(),
            removeFavorite: context.read<RemoveFavorite>(),
          ),
        ),
        BlocProvider<MealPlanBloc>(
          create: (context) => MealPlanBloc(
            loadMealPlans: context.read<LoadMealPlans>(),
            saveMealPlan: context.read<SaveMealPlan>(),
            deleteMealPlan: context.read<DeleteMealPlan>(),
            addFavoritesMealPlan: context.read<AddFavoritesMealPlan>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Finder',
      routerConfig: router,
      theme: appTheme,
    );
  }
}
