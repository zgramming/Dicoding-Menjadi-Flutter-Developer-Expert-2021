import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/common/failure.dart';
import 'package:ditonton/src/data/models/tv/tv_model.dart';
import 'package:ditonton/src/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:ditonton/src/presentation/cubit/tv/tv_series_top_rated_cubit.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TVSeriesTopRatedCubit cubit;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    cubit = TVSeriesTopRatedCubit(getTopRatedTVSeries: mockGetTopRatedTVSeries);
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Series Top Rated',
    () {
      final mockListTV = jsonListTopRatedTV.map((e) => TVModel.fromJson(e).toEntity()).toList();

      blocTest<TVSeriesTopRatedCubit, TVSeriesTopRatedState>(
        'should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetTopRatedTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          TVSeriesTopRatedLoadingState(),
          TVSeriesTopRatedLoadedState(items: mockListTV),
        ],
      );

      blocTest<TVSeriesTopRatedCubit, TVSeriesTopRatedState>(
        'should emitsInOrder [Loading, Error] when unsuccess',
        build: () {
          when(mockGetTopRatedTVSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(),
        expect: () => [
          TVSeriesTopRatedLoadingState(),
          TVSeriesTopRatedErrorState('error'),
        ],
      );
    },
  );
}
