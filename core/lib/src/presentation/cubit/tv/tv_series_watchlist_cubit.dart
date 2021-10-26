import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_watchlist_tv_series.dart';

part './tv_series_watchlist_state.dart';

class TVSeriesWatchlistCubit extends Cubit<TVSeriesWatchlistState> {
  TVSeriesWatchlistCubit({
    required this.getWatchlistTVSeries,
  }) : super(const TVSeriesWatchlistInitialState());

  final GetWatchlistTVSeries getWatchlistTVSeries;

  Future<void> get() async {
    emit(const TVSeriesWatchlistLoadingState());
    final result = await getWatchlistTVSeries.execute();
    result.fold(
      (failure) => emit(TVSeriesWatchlistErrorState(failure.message)),
      (values) => emit(TVSeriesWatchlistLoadedState(items: values)),
    );
  }
}
