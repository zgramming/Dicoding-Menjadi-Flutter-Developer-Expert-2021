part of 'movie_detail_cubit.dart';

abstract class MovieDetailState {
  const MovieDetailState();
}

class MovieDetailInitialState extends MovieDetailState {
  const MovieDetailInitialState();
}

class MovieDetailLoadingState extends MovieDetailState {
  const MovieDetailLoadingState();
}

class MovieDetailErrorState extends MovieDetailState with EquatableMixin {
  const MovieDetailErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  MovieDetailErrorState copyWith({
    String? message,
  }) {
    return MovieDetailErrorState(
      message ?? this.message,
    );
  }
}

class MovieDetailLoadedState extends MovieDetailState with EquatableMixin {
  const MovieDetailLoadedState({
    required this.movie,
    this.isAddedToWatchlist = false,
    this.messageWatchlist = '',
  });

  final MovieDetail movie;
  final bool isAddedToWatchlist;
  final String messageWatchlist;

  MovieDetailLoadedState setMessageWatchlist(String message) => copyWith(messageWatchlist: message);
  MovieDetailLoadedState setIsAddedToWatchlist(bool value) => copyWith(isAddedToWatchlist: value);

  @override
  List<Object> get props => [movie, isAddedToWatchlist, messageWatchlist];

  @override
  bool get stringify => true;

  MovieDetailLoadedState copyWith({
    MovieDetail? movie,
    bool? isAddedToWatchlist,
    String? messageWatchlist,
  }) {
    return MovieDetailLoadedState(
      movie: movie ?? this.movie,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      messageWatchlist: messageWatchlist ?? this.messageWatchlist,
    );
  }
}
