import 'package:recipe_finder/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:recipe_finder/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class LoadMealPlans {
  final MealPlanRepository repository;

  LoadMealPlans({required this.repository});

  Future<Map<String, List<MealPlanModel>>> call() {
    final repo = repository.loadMealPlans();
    return repo;
  }
}
