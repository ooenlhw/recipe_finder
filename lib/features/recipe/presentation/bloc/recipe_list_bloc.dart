import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipe/domain/entities/recipe_entity.dart';
import 'package:recipe_finder/features/recipe/domain/usecases/get_recipes_by_ingredients.dart';

part 'recipe_list_event.dart';
part 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  final GetRecipesByIngredients getRecipesByIngredients;

  RecipeListBloc({required this.getRecipesByIngredients})
      : super(RecipeListInitial()) {
    on<FetchRecipesByIngredientsEvent>(_onFetchRecipesByIngredients);
  }

  Future<void> _onFetchRecipesByIngredients(
    FetchRecipesByIngredientsEvent event,
    Emitter<RecipeListState> emit,
  ) async {
    emit(RecipeListLoading());
    try {
      final Either<Failure, List<RecipeEntity>> recipes =
          await getRecipesByIngredients(event.ingredients);
      print('Recipes by ingredients: $recipes');
      recipes.fold(
        (failure) => emit(RecipeListError(failure.message)),
        (recipes) => emit(RecipeListLoaded(recipes)),
      );
    } catch (e) {
      emit(RecipeListError(
          'Failed to load recipes by ingredients: ${e.toString()}'));
    }
  }
}
