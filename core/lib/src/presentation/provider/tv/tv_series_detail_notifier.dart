import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/tv/tv_detail.dart';
import '../../../domain/usecases/tv/get_detail_tv_series.dart';
import '../../../domain/usecases/tv/get_watch_list_status_tv_series.dart';
import '../../../domain/usecases/tv/remove_watchlist_tv_series.dart';
import '../../../domain/usecases/tv/save_watchlist_tv_series.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  final GetDetailTVSeries getDetailTVSeries;
  final GetWatchListStatusTVSeries getWatchListStatusTVSeries;
  final SaveWatchlistTVSeries saveWatchlistTVSeries;
  final RemoveWatchlistTVSeries removeWatchlistTVSeries;

  TVSeriesDetailNotifier({
    required this.getDetailTVSeries,
    required this.getWatchListStatusTVSeries,
    required this.saveWatchlistTVSeries,
    required this.removeWatchlistTVSeries,
  });

  /// Message
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late TVDetail _item;
  TVDetail get item => _item;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> get(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getDetailTVSeries.execute(id);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (value) {
        _item = value;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  /// START Local Database Section
  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVDetail tv) async {
    final result = await saveWatchlistTVSeries.execute(tv);

    result.fold(
      (failure) {
        log('masuk error insert ${failure.message}');
        _watchlistMessage = failure.message;
      },
      (successMessage) {
        log('masuk success insert $successMessage');
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVDetail tv) async {
    final result = await removeWatchlistTVSeries.execute(tv);

    result.fold(
      (failure) {
        log('masuk error hapus ${failure.message} ');
        _watchlistMessage = failure.message;
      },
      (successMessage) {
        log('masuk success hapus $successMessage');
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTVSeries.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }

  /// END Local Database Section
}
