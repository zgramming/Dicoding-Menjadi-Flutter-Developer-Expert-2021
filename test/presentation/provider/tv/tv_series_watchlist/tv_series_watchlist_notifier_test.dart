import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/src/data/models/tv/tv_model.dart';
import 'package:ditonton/src/domain/usecases/tv/get_watchlist_tv_series.dart';
import 'package:ditonton/src/presentation/provider/tv/tv_series_watchlist_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTVSeries])
void main() {
  late TVSeriesWatchlistNotifier notifier;
  late MockGetWatchlistTVSeries getWatchlistTVSeries;
  setUp(() {
    getWatchlistTVSeries = MockGetWatchlistTVSeries();
    notifier = TVSeriesWatchlistNotifier(getWatchlistTVSeries: getWatchlistTVSeries);
  });

  final mockListTV = jsonListSearchTV.map((e) => TVModel.fromJson(e).toEntity()).toList();
  group('watchlist TV Series', () {
    test('state should be loading when function success called', () async {
      /// arrange
      when(getWatchlistTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));

      /// act
      notifier.get();

      /// assert
      expect(notifier.state, RequestState.Loading);
    });

    test('state should be loaded when function success called', () async {
      /// arrange
      when(getWatchlistTVSeries.execute()).thenAnswer((_) async => Right(mockListTV));

      /// act
      await notifier.get();

      /// assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.items, mockListTV);
    });

    test('state should be error when function success called', () async {
      /// arrange
      when(getWatchlistTVSeries.execute()).thenAnswer((_) async => Left(DatabaseFailure('error')));

      /// act
      await notifier.get();

      /// assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'error');
    });
  });
}
