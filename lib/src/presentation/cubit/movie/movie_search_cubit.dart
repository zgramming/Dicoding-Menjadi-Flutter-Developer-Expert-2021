import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part './movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit({
    required this.searchMovies,
  }) : super(const MovieSearchInitialState());
  final SearchMovies searchMovies;
  Future<void> get(String query) async {
    final result = await searchMovies.execute(query);
    result.fold(
      (failure) => emit(
        MovieSearchErrorState(failure.message),
      ),
      (values) => emit(
        MovieSearchLoadedState(items: values),
      ),
    );
  }
}
