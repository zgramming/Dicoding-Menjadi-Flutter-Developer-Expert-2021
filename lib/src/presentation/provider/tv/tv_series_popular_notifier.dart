import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_popular_tv_series.dart';

class TVSeriesPopularNotifier extends ChangeNotifier {
  TVSeriesPopularNotifier({
    required this.getPopularTVSeries,
  });

  final GetPopularTVSeries getPopularTVSeries;

  List<TV> _items = const [];
  List<TV> get items => _items;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> get() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();

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
