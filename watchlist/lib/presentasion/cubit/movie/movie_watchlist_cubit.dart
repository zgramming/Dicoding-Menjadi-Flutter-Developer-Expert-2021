import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistCubit extends Cubit<MovieWatchlistState> {
  MovieWatchlistCubit({
    required this.getWatchlistMovies,
  }) : super(const MovieWatchlistInitialState());

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> get() async {
    emit(const MovieWatchlistLoadingState());
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(MovieWatchlistErrorState(failure.message)),
      (values) => emit(MovieWatchlistLoadedState(items: values)),
    );
  }
}
