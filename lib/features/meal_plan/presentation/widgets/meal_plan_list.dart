import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';

Widget MealPlanList(List<MealPlanModel> mealPlans, BuildContext context) {
  if (mealPlans.isEmpty) {
    return const Center(child: Text("No meal plans yet."));
  }
  final daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      SizedBox(
        // Give bounded height!
        height: 300,
        child: ListView.builder(
          itemCount: mealPlans.length,
          itemBuilder: (context, index) {
            final plan = mealPlans[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan ID and Delete icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Plan ID: ${plan.id}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<MealPlanBloc>()
                                .add(DeleteMealPlanEvent(plan.id));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Recipes per day
                    ...List.generate(daysOfWeek.length, (i) {
                      final recipe = (i < plan.recipes.length)
                          ? plan.recipes[i].title
                          : 'No recipe';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '${daysOfWeek[i]}: $recipe',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
