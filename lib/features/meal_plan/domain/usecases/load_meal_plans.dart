import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class LoadMealPlans {
  final MealPlanRepository repository;

  LoadMealPlans({required this.repository});

  Future<Map<String, List<int>>> call() {
    return repository.loadMealPlans();
  }
}
