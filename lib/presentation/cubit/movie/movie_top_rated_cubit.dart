import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';

part './movie_top_rated_state.dart';

class MovieTopRatedCubit extends Cubit<MovieTopRatedState> {
  MovieTopRatedCubit({
    required this.getTopRatedMovies,
  }) : super(const MovieTopRatedInitialState());

  final GetTopRatedMovies getTopRatedMovies;
  Future<void> get() async {
    emit(const MovieTopRatedInitialState());

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(MovieTopRatedErrorState(failure.message)),
      (values) => emit(MovieTopRatedLoadedState(items: values)),
    );
  }
}
