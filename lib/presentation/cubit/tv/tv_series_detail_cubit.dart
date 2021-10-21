import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_detail_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watch_list_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv_series.dart';

part 'tv_series_detail_state.dart';

class TVSeriesDetailCubit extends Cubit<TVSeriesDetailState> {
  TVSeriesDetailCubit({
    required this.getDetailTVSeries,
    required this.getWatchListStatusTVSeries,
    required this.saveWatchlistTVSeries,
    required this.removeWatchlistTVSeries,
  }) : super(const TVSeriesDetailInitialState());

  final GetDetailTVSeries getDetailTVSeries;
  final GetWatchListStatusTVSeries getWatchListStatusTVSeries;
  final SaveWatchlistTVSeries saveWatchlistTVSeries;
  final RemoveWatchlistTVSeries removeWatchlistTVSeries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  Future<void> get(int id) async {
    emit(TVSeriesDetailLoadingState());
    final result = await getDetailTVSeries.execute(id);
    result.fold(
      (failure) => emit(TVSeriesDetailErrorState(failure.message)),
      (value) => emit(TVSeriesDetailLoadedState(tv: value)),
    );
  }

  Future<void> saveWatchlist(TVDetail tv) async {
    final result = await saveWatchlistTVSeries.execute(tv);
    result.fold(
      (failure) => emit((state as TVSeriesDetailLoadedState).setMessage(failure.message)),
      (value) => emit((state as TVSeriesDetailLoadedState).setMessage(value)),
    );

    await getWatchlistStatus(tv.id);
  }

  Future<void> removeWatchlist(TVDetail tv) async {
    final result = await removeWatchlistTVSeries.execute(tv);
    result.fold(
      (failure) => emit((state as TVSeriesDetailLoadedState).setMessage(failure.message)),
      (value) => emit((state as TVSeriesDetailLoadedState).setMessage(value)),
    );

    await getWatchlistStatus(tv.id);
  }

  Future<void> getWatchlistStatus(int id) async {
    final result = await getWatchListStatusTVSeries.execute(id);

    if (state is TVSeriesDetailLoadedState) {
      emit((state as TVSeriesDetailLoadedState).setAddedWatchlist(result));
    }
  }
}
