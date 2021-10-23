part of 'movie_search_cubit.dart';

abstract class MovieSearchState {
  const MovieSearchState();
}

class MovieSearchInitialState extends MovieSearchState {
  const MovieSearchInitialState();
}

class MovieSearchLoadingState extends MovieSearchState {
  const MovieSearchLoadingState();
}

class MovieSearchErrorState extends MovieSearchState with EquatableMixin {
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

class MovieSearchLoadedState extends MovieSearchState with EquatableMixin {
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
