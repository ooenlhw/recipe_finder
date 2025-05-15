import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:recipe_finder/features/meal_plan/presentation/bloc/meal_plan_bloc.dart';

Widget MealPlanList(List<MealPlanModel> mealPlans, BuildContext context) {
  if (mealPlans.isEmpty) {
    return const Center(child: Text("No meal plans yet."));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Meal Plan Lists',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 10),
      SizedBox(
        // Give bounded height!
        height: 300,
        child: ListView.builder(
          itemCount: mealPlans.length,
          itemBuilder: (context, index) {
            final plan = mealPlans[index];
            print('plan json: ${plan.toJson()}');
            final recipeTitles =
                plan.recipes.map((recipe) => recipe.id).join(', ');
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                title: Text('Week: ${plan.id}'),
                subtitle: Text('Recipes: $recipeTitles'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<MealPlanBloc>()
                        .add(DeleteMealPlanEvent(plan.id));
                  },
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
