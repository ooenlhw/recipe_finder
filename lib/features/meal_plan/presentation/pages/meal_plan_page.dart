import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/favorites/data/models/favorite_recipe_model.dart';
import 'package:recipe_finder/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';
import 'package:recipe_finder/features/meal_plan/presentation/widgets/meal_plan_list.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  String? selectedWeekKey;
  String? formattedWeekKey;
  final weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  Map<String, FavoriteRecipeModel?> selectedRecipesPerDay = {
    'Monday': null,
    'Tuesday': null,
    'Wednesday': null,
    'Thursday': null,
    'Friday': null,
    'Saturday': null,
    'Sunday': null,
  };

  String formatWeekKey(String weekKey) {
    final year = weekKey.substring(0, 4);
    final week = weekKey.substring(5);
    weekKey = '$year Week $week';
    return weekKey;
  }

  String getWeekKey(DateTime date) {
    final weekNumber = _getWeekNumber(date);
    final year = date.year;
    return '${year}W${weekNumber.toString().padLeft(2, '0')}'; // e.g., "2025W20"
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - 1; // Monday is the first day
    final firstMonday = firstDayOfYear.subtract(Duration(days: daysOffset));
    final diff = date.difference(firstMonday);
    return ((diff.inDays) / 7).ceil();
  }

  void pickWeekFromCalendar() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final weekKey = getWeekKey(pickedDate); // Example: "2025W20"
      setState(() {
        selectedWeekKey = weekKey;
        formattedWeekKey = formatWeekKey(weekKey); // Example: "2025 Week 20"
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavorites());
    context.read<MealPlanBloc>().add(LoadMealPlansEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Weekly Meal Plan',
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: BlocConsumer<MealPlanBloc, MealPlanState>(
        listener: (context, state) {
          print('MealPlanPage state: $state');
          if (state is MealPlanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is MealPlanSaved) {
            // Reset the selected recipe for each day and the selectedWeekKey
            setState(() {
              selectedRecipesPerDay = {
                'Monday': null,
                'Tuesday': null,
                'Wednesday': null,
                'Thursday': null,
                'Friday': null,
                'Saturday': null,
                'Sunday': null,
              };
              selectedWeekKey = null;
            });
          }
        },
        builder: (context, state) {
          if (state is MealPlanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MealPlanLoaded) {
            print('MealPlanPage state: $state');
            print('state mealPlans: ${state.mealPlans}');
            return BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, favState) {
                if (favState is FavoritesLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (favState is FavoritesLoaded) {
                  if (favState.favorites.isEmpty) {
                    return const Center(child: Text('Add to favorites first'));
                  }
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: pickWeekFromCalendar,
                                    icon: const Icon(Icons.calendar_today),
                                    label: Text(
                                        formattedWeekKey ?? 'Select a Week'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Assign Recipes to Each Day',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            ...weekdays.map((day) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: DropdownButtonFormField<
                                    FavoriteRecipeModel>(
                                  value: selectedRecipesPerDay[day],
                                  isDense: true,
                                  hint: Text('Select recipe for $day'),
                                  isExpanded: true,
                                  items: favState.favorites.map((recipe) {
                                    return DropdownMenuItem<
                                        FavoriteRecipeModel>(
                                      value: recipe,
                                      child: Text(recipe.title,
                                          overflow: TextOverflow.ellipsis),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRecipesPerDay[day] = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: (formattedWeekKey == null ||
                                      selectedRecipesPerDay.values
                                          .every((id) => id == null))
                                  ? null
                                  : () {
                                      final selectedRecipe =
                                          selectedRecipesPerDay.values
                                              .whereType<FavoriteRecipeModel>()
                                              .toList();
                                      context.read<MealPlanBloc>().add(
                                            SaveMealPlanEvent(
                                              weekKey: formattedWeekKey!,
                                              favoriteRecipes: selectedRecipe,
                                            ),
                                          );
                                    },
                              icon: const Icon(Icons.save),
                              label: const Text('Save Meal Plan'),
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 10),
                            const Text(
                              'Saved Meal Plans',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            MealPlanList(state.mealPlans, context),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No favorites available.'),
                  );
                }
              },
            );
          } else if (state is MealPlanError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('...'));
          }
        },
      ),
    );
  }
}
