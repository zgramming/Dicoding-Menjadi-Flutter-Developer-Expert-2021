import 'dart:developer';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter/cupertino.dart';

import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_series.dart';

class TVSeriesWatchlistNotifier extends ChangeNotifier {
  final GetWatchlistTVSeries getWatchlistTVSeries;
  TVSeriesWatchlistNotifier({
    required this.getWatchlistTVSeries,
  });

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _items = const [];
  List<TV> get items => _items;

  Future<void> get() async {
    final result = await getWatchlistTVSeries.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (values) {
        _state = RequestState.Loaded;
        _items = [...values];
        log('itemWatchlist TVSeries $values');
        notifyListeners();
      },
    );
  }
}
