import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/usecases/tv/get_recommendation_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_recommendations_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendations_notifier_test.mocks.dart';

@GenerateMocks([GetRecommendationTVSeries])
void main() {
  late TVSeriesRecommendationsNotifier notifier;
  late MockGetRecommendationTVSeries getRecommendationTVSeries;
  setUp(() {
    getRecommendationTVSeries = MockGetRecommendationTVSeries();
    notifier = TVSeriesRecommendationsNotifier(
      getRecommendationTVSeries: getRecommendationTVSeries,
    );
  });

  final mockTVDetail = TVDetailResponse.fromJson(jsonDetailTV).toEntity();
  final mockListTV = jsonListRecommendationTV.map((e) => TVModel.fromJson(e).toEntity()).toList();
  group('TV Series Recommendation', () {
    test("state should be loading when function success called", () async {
      /// arrange
      when(getRecommendationTVSeries.execute(mockTVDetail.id))
          .thenAnswer((_) async => Right(mockListTV));

      /// act
      notifier.get(mockTVDetail.id);

      /// assert
      expect(notifier.state, RequestState.Loading);
    });

    test('state should be loaded when function success called', () async {
      /// arrange
      when(getRecommendationTVSeries.execute(mockTVDetail.id))
          .thenAnswer((_) async => Right(mockListTV));

      /// act
      await notifier.get(mockTVDetail.id);

      /// assert
      expect(notifier.items, mockListTV);
      expect(notifier.state, RequestState.Loaded);
    });

    test('state should be error when function success called', () async {
      /// arrange
      when(getRecommendationTVSeries.execute(mockTVDetail.id))
          .thenAnswer((_) async => Left(ServerFailure('error')));

      /// act
      await notifier.get(mockTVDetail.id);

      /// assert
      expect(notifier.message, 'error');
      expect(notifier.state, RequestState.Error);
    });
  });
}
