import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';

part 'tv_series_popular_state.dart';

class TVSeriesPopularCubit extends Cubit<TVSeriesPopularState> {
  TVSeriesPopularCubit({
    required this.getPopularTVSeries,
  }) : super(const TVSeriesPopularInitialState());

  final GetPopularTVSeries getPopularTVSeries;
  Future<void> get() async {
    emit(TVSeriesPopularLoadingState());
    final result = await getPopularTVSeries.execute();
    result.fold(
      (failure) => emit(TVSeriesPopularErrorState(failure.message)),
      (values) => emit(TVSeriesPopularLoadedState(items: values)),
    );
  }
}
