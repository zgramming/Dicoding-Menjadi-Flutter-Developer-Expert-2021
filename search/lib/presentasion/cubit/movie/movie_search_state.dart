part of 'movie_search_cubit.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitialState extends MovieSearchState {
  const MovieSearchInitialState();
}

class MovieSearchLoadingState extends MovieSearchState {
  const MovieSearchLoadingState();
}

class MovieSearchErrorState extends MovieSearchState {
  const MovieSearchErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  MovieSearchErrorState copyWith({
    String? message,
  }) {
    return MovieSearchErrorState(
      message ?? this.message,
    );
  }
}

class MovieSearchLoadedState extends MovieSearchState {
  const MovieSearchLoadedState({
    required this.items,
  });

  final List<Movie> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  MovieSearchLoadedState copyWith({
    List<Movie>? items,
  }) {
    return MovieSearchLoadedState(
      items: items ?? this.items,
    );
  }
}
