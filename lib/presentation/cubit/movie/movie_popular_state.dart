part of 'movie_popular_cubit.dart';

abstract class MoviePopularState {
  const MoviePopularState();
}

class MoviePopularInitialState extends MoviePopularState {
  const MoviePopularInitialState();
}

class MoviePopularLoadingState extends MoviePopularState {
  const MoviePopularLoadingState();
}

class MoviePopularErrorState extends MoviePopularState with EquatableMixin {
  const MoviePopularErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  MoviePopularErrorState copyWith({
    String? message,
  }) {
    return MoviePopularErrorState(
      message ?? this.message,
    );
  }
}

class MoviePopularLoadedState extends MoviePopularState with EquatableMixin {
  const MoviePopularLoadedState({
    required this.items,
  });

  final List<Movie> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  MoviePopularLoadedState copyWith({
    List<Movie>? items,
  }) {
    return MoviePopularLoadedState(
      items: items ?? this.items,
    );
  }
}
