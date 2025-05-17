import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe_entity.dart';
import 'package:recipe_finder/features/recipe/domain/usecases/get_recipe_by_id.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeById getRecipeById;

  RecipeDetailBloc({required this.getRecipeById})
      : super(RecipeDetailInitial()) {
    on<FetchRecipeByIdEvent>(_onFetchRecipeById);
  }

  Future<void> _onFetchRecipeById(
    FetchRecipeByIdEvent event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(RecipeDetailLoading());
    try {
      final Either<Failure, RecipeEntity> recipe =
          await getRecipeById(event.id);
      print('Recipe by id: $recipe');
      recipe.fold(
        (failure) => emit(RecipeDetailError(failure.message)),
        (recipe) => emit(RecipeDetailLoaded(recipe)),
      );
    } catch (e) {
      emit(RecipeDetailError('Failed to load recipe by id: ${e.toString()}'));
    }
  }
}
