import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/tv/tv_detail/tv_detail_model.dart';
import 'package:ditonton/domain/usecases/tv/get_detail_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_watch_list_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/tv_series_detail_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTVSeries,
  GetWatchListStatusTVSeries,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries,
])
void main() {
  late TVSeriesDetailNotifier notifier;

  late MockGetDetailTVSeries getDetailTVSeries;
  late MockGetWatchListStatusTVSeries getWatchListStatusTVSeries;
  late MockSaveWatchlistTVSeries saveWatchlistTVSeries;
  late MockRemoveWatchlistTVSeries removeWatchlistTVSeries;

  setUp(() {
    getDetailTVSeries = MockGetDetailTVSeries();
    getWatchListStatusTVSeries = MockGetWatchListStatusTVSeries();
    saveWatchlistTVSeries = MockSaveWatchlistTVSeries();
    removeWatchlistTVSeries = MockRemoveWatchlistTVSeries();

    notifier = TVSeriesDetailNotifier(
      getDetailTVSeries: getDetailTVSeries,
      getWatchListStatusTVSeries: getWatchListStatusTVSeries,
      saveWatchlistTVSeries: saveWatchlistTVSeries,
      removeWatchlistTVSeries: removeWatchlistTVSeries,
    )..addListener(() {});
  });

  const int id = 1;

  final mockTVDetail = TVDetailResponse.fromJson(jsonDetailTV).toEntity();

  void _arrangeUseCase({
    bool throwError = false,
  }) {
    if (throwError) {
      when(getDetailTVSeries.execute(id))
          .thenAnswer((_) async => Left(ServerFailure('server failure')));
    } else {
      when(getDetailTVSeries.execute(id)).thenAnswer((_) async => Right(mockTVDetail));
    }
  }

  group('Get TV Series Detail', () {
    test('should change state to loading', () async {
      /// arrange
      _arrangeUseCase();

      /// act
      notifier.get(id);

      /// assert
      expect(notifier.state, RequestState.Loading);
    });

    test('should change state to loaded', () async {
      ///arrange
      _arrangeUseCase();

      ///act
      await notifier.get(id);

      ///assert
      expect(notifier.item, mockTVDetail);
      expect(notifier.state, RequestState.Loaded);
    });

    test('should change state to error', () async {
      /// arrange
      _arrangeUseCase(throwError: true);

      /// act
      await notifier.get(id);

      /// assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'server failure');
    });
  });

  group('Watchlist', () {
    test('should get watchlist status', () async {
      ///arrange
      when(getWatchListStatusTVSeries.execute(id)).thenAnswer((_) async => true);

      ///act
      await notifier.loadWatchlistStatus(id);

      ///assert
      expect(notifier.isAddedToWatchlist, true);
    });
    test('should execute save watchlist when function called', () async {
      ///arrange
      when(saveWatchlistTVSeries.execute(mockTVDetail)).thenAnswer((_) async => Right('success'));
      when(getWatchListStatusTVSeries.execute(mockTVDetail.id)).thenAnswer((_) async => true);

      ///act
      await notifier.addWatchlist(mockTVDetail);

      ///assert
      verify(saveWatchlistTVSeries.execute(mockTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      /// arrange
      when(removeWatchlistTVSeries.execute(mockTVDetail))
          .thenAnswer((_) async => Right('success remove'));
      when(getWatchListStatusTVSeries.execute(mockTVDetail.id)).thenAnswer((_) async => true);

      /// act
      await notifier.removeFromWatchlist(mockTVDetail);

      /// assert
      verify(removeWatchlistTVSeries.execute(mockTVDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      /// arrange
      when(saveWatchlistTVSeries.execute(mockTVDetail)).thenAnswer((_) async => Right('success'));
      when(getWatchListStatusTVSeries.execute(mockTVDetail.id)).thenAnswer((_) async => true);

      /// act
      await notifier.addWatchlist(mockTVDetail);

      /// assert
      verify(saveWatchlistTVSeries.execute(mockTVDetail));
      expect(notifier.watchlistMessage, 'success');
      expect(notifier.isAddedToWatchlist, true);
    });

    test('should update watchlist message when add watchlist failed', () async {
      /// arrange
      when(saveWatchlistTVSeries.execute(mockTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('error')));
      when(getWatchListStatusTVSeries.execute(mockTVDetail.id)).thenAnswer((_) async => true);

      /// act
      await notifier.addWatchlist(mockTVDetail);

      /// assert
      verify(saveWatchlistTVSeries.execute(mockTVDetail));
      expect(notifier.watchlistMessage, 'error');
    });
  });
}
