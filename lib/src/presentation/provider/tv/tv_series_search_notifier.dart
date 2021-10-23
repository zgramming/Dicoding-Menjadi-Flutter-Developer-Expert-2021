import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/search_tv_series.dart';

class TVSeriesSearchNotifier extends ChangeNotifier {
  final SearchTVSeries searchTVSeries;
  TVSeriesSearchNotifier({
    required this.searchTVSeries,
  });

  List<TV> _items = const [];
  List<TV> get items => _items;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVSeries.execute(query);
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (values) {
      _state = RequestState.Loaded;
      _items = [...values];
      notifyListeners();
    });
  }
}
