import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/src/common/failure.dart';
import 'package:ditonton/src/data/models/tv/tv_model.dart';
import 'package:ditonton/src/domain/entities/movie.dart';
import 'package:ditonton/src/domain/usecases/tv/search_tv_series.dart';
import 'package:ditonton/src/presentation/cubit/tv/tv_series_search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_search_cubit_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late MockSearchTVSeries mockSearchTVSeries;
  late TVSeriesSearchCubit cubit;
  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    cubit = TVSeriesSearchCubit(searchTVSeries: mockSearchTVSeries);
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Series Search',
    () {
      const query = 'your lie in april';
      final mockListTV = jsonListSearchTV.map((e) => TVModel.fromJson(e).toEntity()).toList();

      blocTest<TVSeriesSearchCubit, TVSeriesSearchState>(
        'should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockSearchTVSeries.execute(query)).thenAnswer((_) async => Right(mockListTV));
          return cubit;
        },
        act: (bloc) => bloc.get(query),
        expect: () => [
          TVSeriesSearchLoadingState(),
          TVSeriesSearchLoadedState(items: mockListTV),
        ],
      );

      blocTest<TVSeriesSearchCubit, TVSeriesSearchState>(
        'should emitsInOrder [Loading, Error] when unsuccess',
        build: () {
          when(mockSearchTVSeries.execute(query))
              .thenAnswer((_) async => Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(query),
        expect: () => [
          TVSeriesSearchLoadingState(),
          TVSeriesSearchErrorState('error'),
        ],
      );
    },
  );
}