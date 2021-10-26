import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/src/data/models/tv/tv_model.dart';
import 'package:ditonton/src/domain/usecases/tv/get_recommendation_tv_series.dart';
import 'package:ditonton/src/presentation/cubit/tv/tv_series_recommendations_cubit.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetRecommendationTVSeries])
void main() {
  late TVSeriesRecommendationsCubit cubit;
  late MockGetRecommendationTVSeries mockGetRecommendationTVSeries;

  setUp(() {
    mockGetRecommendationTVSeries = MockGetRecommendationTVSeries();
    cubit = TVSeriesRecommendationsCubit(getRecommendationTVSeries: mockGetRecommendationTVSeries);
  });

  tearDown(() async {
    await cubit.close();
  });

  group(
    'TV Series Recommendations ',
    () {
      final mockTVDetail = TVDetailResponse.fromJson(jsonDetailTV).toEntity();
      final mockListTV =
          jsonListRecommendationTV.map((e) => TVModel.fromJson(e).toEntity()).toList();
      blocTest<TVSeriesRecommendationsCubit, TVSeriesRecommendationsState>(
        'should emitsInOrder [Loading, Loaded] when success',
        build: () {
          when(mockGetRecommendationTVSeries.execute(mockTVDetail.id))
              .thenAnswer((_) async => Right(mockListTV));
          return cubit;
        },
        act: (bloc) => bloc.get(mockTVDetail.id),
        expect: () => [
          TVSeriesRecommendationsLoadingState(),
          TVSeriesRecommendationsLoadedState(items: mockListTV),
        ],
      );

      blocTest<TVSeriesRecommendationsCubit, TVSeriesRecommendationsState>(
        'should emitsInOrder [Loading, Error] when unsuccess',
        build: () {
          when(mockGetRecommendationTVSeries.execute(mockTVDetail.id))
              .thenAnswer((_) async => Left(ServerFailure('error')));
          return cubit;
        },
        act: (bloc) => bloc.get(mockTVDetail.id),
        expect: () => [
          TVSeriesRecommendationsLoadingState(),
          TVSeriesRecommendationsErrorState('error'),
        ],
      );
    },
  );
}
