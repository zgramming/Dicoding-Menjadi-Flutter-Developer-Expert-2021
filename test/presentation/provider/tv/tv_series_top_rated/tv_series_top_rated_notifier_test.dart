import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TVSeriesTopRatedNotifier notifier;
  late MockGetTopRatedTVSeries getTopRatedTVSeries;
  setUp(() {
    getTopRatedTVSeries = MockGetTopRatedTVSeries();
    notifier = TVSeriesTopRatedNotifier(getTopRatedTVSeries: getTopRatedTVSeries);
  });

  final mockListTV = jsonListTopRatedTV.map((e) => TVModel.fromJson(e).toEntity()).toList();
  group('Top Rated TV Series', () {
    test('state should be loading when function success called', () async {
      /// arrange
      when(getTopRatedTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));

      /// act
      notifier.get();

      /// assert
      expect(notifier.state, RequestState.Loading);
    });

    test('state should be loaded when function success called', () async {
      /// arrange
      when(getTopRatedTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));

      /// act
      await notifier.get();

      /// assert
      expect(notifier.items, mockListTV);
      expect(notifier.state, RequestState.Loaded);
    });

    test('state shoulb be error when function success called', () async {
      /// arrange
      when(getTopRatedTVSeries.execute()).thenAnswer((_) async => Left(ServerFailure('error')));

      /// act
      await notifier.get();

      /// assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'error');
    });
  });
}
