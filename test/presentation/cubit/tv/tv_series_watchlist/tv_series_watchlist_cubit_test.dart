import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/data/models/tv/tv_model.dart';
import 'package:ditonton/src/domain/usecases/tv/get_watchlist_tv_series.dart';
import 'package:ditonton/src/presentation/cubit/tv/tv_series_watchlist_cubit.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTVSeries])
void main() {
  late TVSeriesWatchlistCubit cubit;
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    cubit = TVSeriesWatchlistCubit(getWatchlistTVSeries: mockGetWatchlistTVSeries);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('TV Series Watchlist', () {
    final mockListTV = jsonListSearchTV.map((e) => TVModel.fromJson(e).toEntity()).toList();

    blocTest<TVSeriesWatchlistCubit, TVSeriesWatchlistState>(
      'should emitsInOrder [Loading, Loaded] when success',
      build: () {
        when(mockGetWatchlistTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));
        return cubit;
      },
      act: (bloc) => bloc.get(),
      expect: () => [
        TVSeriesWatchlistLoadingState(),
        TVSeriesWatchlistLoadedState(items: mockListTV),
      ],
    );

    blocTest<TVSeriesWatchlistCubit, TVSeriesWatchlistState>(
      'should emitsInOrder [Loading, Error] when unsuccess',
      build: () {
        when(mockGetWatchlistTVSeries.execute()).thenAnswer(
          (_) async => Left(ServerFailure('error')),
        );
        return cubit;
      },
      act: (bloc) => bloc.get(),
      expect: () => [
        TVSeriesWatchlistLoadingState(),
        TVSeriesWatchlistErrorState('error'),
      ],
    );
  });
}
