part of 'tv_series_detail_cubit.dart';

abstract class TVSeriesDetailState {
  const TVSeriesDetailState();
}

class TVSeriesDetailInitialState extends TVSeriesDetailState {
  const TVSeriesDetailInitialState();
}

class TVSeriesDetailLoadingState extends TVSeriesDetailState {
  const TVSeriesDetailLoadingState();
}

class TVSeriesDetailErrorState extends TVSeriesDetailState with EquatableMixin {
  const TVSeriesDetailErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVSeriesDetailErrorState copyWith({
    String? message,
  }) {
    return TVSeriesDetailErrorState(
      message ?? this.message,
    );
  }
}

class TVSeriesDetailLoadedState extends TVSeriesDetailState with EquatableMixin {
  const TVSeriesDetailLoadedState({
    required this.tv,
    this.isAddedToWatchlist = false,
    this.messageWatchlist = '',
  });

  final TVDetail tv;
  final bool isAddedToWatchlist;
  final String messageWatchlist;

  TVSeriesDetailLoadedState setAddedWatchlist(bool value) => copyWith(isAddedToWatchlist: value);
  TVSeriesDetailLoadedState setMessage(String value) => copyWith(messageWatchlist: value);

  @override
  List<Object> get props => [tv, isAddedToWatchlist, messageWatchlist];

  @override
  bool get stringify => true;

  TVSeriesDetailLoadedState copyWith({
    TVDetail? tv,
    bool? isAddedToWatchlist,
    String? messageWatchlist,
  }) {
    return TVSeriesDetailLoadedState(
      tv: tv ?? this.tv,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      messageWatchlist: messageWatchlist ?? this.messageWatchlist,
    );
  }
}
