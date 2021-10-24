part of 'tv_series_detail_cubit.dart';

abstract class TVSeriesDetailState extends Equatable {
  const TVSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TVSeriesDetailInitialState extends TVSeriesDetailState {
  const TVSeriesDetailInitialState();
}

class TVSeriesDetailLoadingState extends TVSeriesDetailState {
  const TVSeriesDetailLoadingState();
}

class TVSeriesDetailErrorState extends TVSeriesDetailState {
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

class TVSeriesDetailLoadedState extends TVSeriesDetailState {
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

class TVSeriesDetailState2 extends Equatable {
  final TVDetail tv;
  final RequestState requestState;
  final String message;
  final String messageWatchlist;
  final bool isAddedToWatchlist;

  const TVSeriesDetailState2({
    this.tv = const TVDetail(),
    this.requestState = RequestState.Empty,
    this.message = '',
    this.messageWatchlist = '',
    this.isAddedToWatchlist = false,
  });

  TVSeriesDetailState2 setTV(TVDetail tv) => copyWith(tv: tv);
  TVSeriesDetailState2 setAddedToWatchlist(bool value) => copyWith(isAddedToWatchlist: value);
  TVSeriesDetailState2 setRequestState(RequestState requestState) =>
      copyWith(requestState: requestState);
  TVSeriesDetailState2 setMessage(String message) => copyWith(message: message);
  TVSeriesDetailState2 setMessageWatchlist(String message) => copyWith(messageWatchlist: message);

  @override
  List<Object> get props {
    return [
      tv,
      requestState,
      message,
      messageWatchlist,
      isAddedToWatchlist,
    ];
  }

  @override
  bool get stringify => true;

  TVSeriesDetailState2 copyWith({
    TVDetail? tv,
    RequestState? requestState,
    String? message,
    String? messageWatchlist,
    bool? isAddedToWatchlist,
  }) {
    return TVSeriesDetailState2(
      tv: tv ?? this.tv,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
      messageWatchlist: messageWatchlist ?? this.messageWatchlist,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }
}
