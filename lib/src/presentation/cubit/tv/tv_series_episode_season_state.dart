part of 'tv_series_episode_season_cubit.dart';

abstract class TVSeriesEpisodeSeasonState {
  const TVSeriesEpisodeSeasonState();
}

class TVSeriesEpisodeSeasonInitialState extends TVSeriesEpisodeSeasonState {
  const TVSeriesEpisodeSeasonInitialState();
}

class TVSeriesEpisodeSeasonLoadingState extends TVSeriesEpisodeSeasonState {
  const TVSeriesEpisodeSeasonLoadingState();
}

class TVSeriesEpisodeSeasonErrorState extends TVSeriesEpisodeSeasonState with EquatableMixin {
  const TVSeriesEpisodeSeasonErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVSeriesEpisodeSeasonErrorState copyWith({
    String? message,
  }) {
    return TVSeriesEpisodeSeasonErrorState(
      message ?? this.message,
    );
  }
}

class TVSeriesEpisodeSeasonLoadedState extends TVSeriesEpisodeSeasonState with EquatableMixin {
  const TVSeriesEpisodeSeasonLoadedState({
    required this.items,
  });

  final List<Episode> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVSeriesEpisodeSeasonLoadedState copyWith({
    List<Episode>? items,
  }) {
    return TVSeriesEpisodeSeasonLoadedState(
      items: items ?? this.items,
    );
  }
}
