import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_recommendation_tv_series.dart';

class TVSeriesRecommendationsNotifier extends ChangeNotifier {
  final GetRecommendationTVSeries getRecommendationTVSeries;
  TVSeriesRecommendationsNotifier({
    required this.getRecommendationTVSeries,
  });

  List<TV> _items = const [];
  List<TV> get items => _items;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> get(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getRecommendationTVSeries.execute(id);
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
