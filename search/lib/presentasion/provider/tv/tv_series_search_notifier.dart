import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../search.dart';

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
