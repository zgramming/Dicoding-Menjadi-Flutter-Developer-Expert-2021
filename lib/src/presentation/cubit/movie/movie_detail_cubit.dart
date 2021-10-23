import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part './movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({
    required this.getMovieDetail,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  }) : super(const MovieDetailInitialState());

  final GetMovieDetail getMovieDetail;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  Future<void> get(int id) async {
    emit(const MovieDetailLoadingState());
    final result = await getMovieDetail.execute(id);
    result.fold(
      (failure) => emit(MovieDetailErrorState(failure.message)),
      (movie) => emit(MovieDetailLoadedState(movie: movie)),
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    result.fold(
      (failure) => emit((state as MovieDetailLoadedState).setMessageWatchlist(failure.message)),
      (value) => emit((state as MovieDetailLoadedState).setMessageWatchlist(value)),
    );
    await getWatchlistStatus(movie.id);
  }

  Future<void> deleteWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);
    result.fold(
      (failure) => emit((state as MovieDetailLoadedState).setMessageWatchlist(failure.message)),
      (value) => emit((state as MovieDetailLoadedState).setMessageWatchlist(value)),
    );
    await getWatchlistStatus(movie.id);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);

    if (state is MovieDetailLoadedState) {
      emit((state as MovieDetailLoadedState).setIsAddedToWatchlist(result));
    }
  }
}
