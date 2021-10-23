import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv_episode.dart';
import '../../../domain/usecases/tv/get_episode_season_tv_series.dart';

class TVSeriesEpisodeSeasonNotifier extends ChangeNotifier {
  TVSeriesEpisodeSeasonNotifier({
    required this.getEpisodeSeasonTVSeries,
  });

  final GetEpisodeSeasonTVSeries getEpisodeSeasonTVSeries;

  List<Episode> _items = [];
  List<Episode> get items => _items;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> get({
    required int id,
    required int seasonNumber,
  }) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getEpisodeSeasonTVSeries.execute(
      id: id,
      seasonNumber: seasonNumber,
    );
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (values) {
        _state = RequestState.Loaded;
        _items = [...values];
        notifyListeners();
      },
    );
  }
}
