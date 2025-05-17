import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:recipe_finder/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:recipe_finder/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/add_favorite.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/get_favorites.dart';
import 'package:recipe_finder/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder/features/meal_plan/data/datasources/meal_plan_local_data_source.dart';
import 'package:recipe_finder/features/meal_plan/data/repositories/meal_plan_repository_impl.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/add_favorites_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/delete_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/load_meal_plans.dart';
import 'package:recipe_finder/features/meal_plan/domain/usecases/save_meal_plan.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import 'package:recipe_finder/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipe/presentation/bloc/recipe_detail_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/recipe/data/datasources/recipe_remote_data_source.dart';
import 'features/recipe/data/datasources/cached_recipes_local_data_source.dart';
import 'features/recipe/data/repositories/recipe_repository_impl.dart';
import 'features/recipe/domain/usecases/get_recipes_by_ingredients.dart';
import 'features/recipe/domain/usecases/get_recipe_by_id.dart';
import 'features/recipe/presentation/bloc/recipe_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());

  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CachedRecipesLocalDataSource>(
    () => CachedRecipesLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<MealPlanLocalDataSource>(
    () => MealPlanLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repositories
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      recipeRemoteDataSource: sl(),
      cachedRecipesLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(favoritesLocalDataSource: sl()),
  );
  sl.registerLazySingleton<MealPlanRepository>(
    () => MealPlanRepositoryImpl(mealPlanLocalDataSource: sl()),
  );
  sl.registerLazySingleton(
    () => FavoritesLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton(
    () => MealPlanLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetRecipesByIngredients(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetRecipeById(repository: sl()),
  );
  sl.registerLazySingleton(
    () => AddFavorite(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RemoveFavorite(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetFavorites(repository: sl()),
  );
  sl.registerLazySingleton(
    () => AddFavoritesMealPlan(repository: sl()),
  );
  sl.registerLazySingleton(
    () => SaveMealPlan(repository: sl()),
  );
  sl.registerLazySingleton(
    () => DeleteMealPlan(repository: sl()),
  );
  sl.registerLazySingleton(
    () => LoadMealPlans(repository: sl()),
  );

  // Blocs
  sl.registerFactory(
    () => RecipeListBloc(
      getRecipesByIngredients: sl(),
    ),
  );
  sl.registerFactory(
    () => RecipeDetailBloc(
      getRecipeById: sl(),
    ),
  );
  sl.registerFactory(
    () => FavoritesBloc(
      addFavorite: sl(),
      removeFavorite: sl(),
      getFavorites: sl(),
    ),
  );
  sl.registerFactory(
    () => MealPlanBloc(
      addFavoritesMealPlan: sl(),
      saveMealPlan: sl(),
      deleteMealPlan: sl(),
      loadMealPlans: sl(),
    ),
  );
}
