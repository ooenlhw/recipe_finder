import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'meal_plan_event.dart';
part 'meal_plan_state.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  MealPlanBloc() : super(MealPlanInitial()) {
    on<MealPlanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
