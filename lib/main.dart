import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_finder/core/routing/router.dart';
import 'package:recipe_finder/core/theme.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import 'package:recipe_finder/features/recipe/presentation/bloc/recipe_detail_bloc.dart';
import 'package:recipe_finder/features/recipe/presentation/bloc/recipe_list_bloc.dart';
import 'service_locator.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final router = createRouter(recipeRepository: di.sl());
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecipeListBloc>(
          create: (_) => di.sl<RecipeListBloc>(),
        ),
        BlocProvider<RecipeDetailBloc>(
          create: (_) => di.sl<RecipeDetailBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => di.sl<FavoritesBloc>(),
        ),
        BlocProvider<MealPlanBloc>(
          create: (_) => di.sl<MealPlanBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Recipe Finder',
        routerConfig: router,
        theme: appTheme,
      ),
    );
  }
}
