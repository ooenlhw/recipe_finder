import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class DeleteMealPlan {
  final MealPlanRepository repository;

  DeleteMealPlan({required this.repository});

  Future<void> call(String weekKey) {
    return repository.deleteMealPlan(weekKey);
  }
}
