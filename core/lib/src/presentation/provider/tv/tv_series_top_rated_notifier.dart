import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_top_rated_tv_series.dart';

class TVSeriesTopRatedNotifier extends ChangeNotifier {
  TVSeriesTopRatedNotifier({
    required this.getTopRatedTVSeries,
  });

  final GetTopRatedTVSeries getTopRatedTVSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _items = const [];
  List<TV> get items => _items;

  String _message = '';
  String get message => _message;

  Future<void> get() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (values) {
      _items = [...values];
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
