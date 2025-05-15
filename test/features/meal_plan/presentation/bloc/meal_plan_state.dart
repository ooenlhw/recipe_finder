part of 'meal_plan_bloc.dart';

abstract class MealPlanState extends Equatable {
  const MealPlanState();  

  @override
  List<Object> get props => [];
}
class MealPlanInitial extends MealPlanState {}
