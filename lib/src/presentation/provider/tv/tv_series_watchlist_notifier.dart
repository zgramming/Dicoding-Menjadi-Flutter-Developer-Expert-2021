import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_watchlist_tv_series.dart';

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
    _state = RequestState.Loading;
    notifyListeners();

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
