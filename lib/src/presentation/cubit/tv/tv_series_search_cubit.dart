import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/search_tv_series.dart';

part './tv_series_search_state.dart';

class TVSeriesSearchCubit extends Cubit<TVSeriesSearchState> {
  TVSeriesSearchCubit({
    required this.searchTVSeries,
  }) : super(const TVSeriesSearchInitialState());

  final SearchTVSeries searchTVSeries;
  Future<void> get(String query) async {
    emit(const TVSeriesSearchLoadingState());
    final result = await searchTVSeries.execute(query);
    result.fold(
      (failure) => emit(
        TVSeriesSearchErrorState(failure.message),
      ),
      (values) => emit(
        TVSeriesSearchLoadedState(items: values),
      ),
    );
  }
}
