// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv/tv.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:ditonton/domain/usecases/tv/get_airing_today_tv_series.dart';

// class TVSeriesAiringTodayNotifier extends ChangeNotifier {
//   final GetAiringTodayTVSeries getAiringTodayTVSeries;
//   TVSeriesAiringTodayNotifier({
//     required this.getAiringTodayTVSeries,
//   });

//   RequestState _state = RequestState.Empty;
//   RequestState get state => _state;

//   List<TV> _items = const [];
//   List<TV> get items => _items;

//   String _message = '';
//   String get message => _message;

//   Future<void> get() async {
//     _state = RequestState.Loading;
//     notifyListeners();

//     final result = await getAiringTodayTVSeries.execute();

//     result.fold((failure) {
//       _message = failure.message;
//       _state = RequestState.Error;
//       notifyListeners();
//     }, (values) {
//       _items = [...values];
//       _state = RequestState.Loaded;
//       notifyListeners();
//     });
//   }
// }
