part of 'tv_series_search_cubit.dart';

abstract class TVSeriesSearchState {
  const TVSeriesSearchState();
}

class TVSeriesSearchInitialState extends TVSeriesSearchState {
  const TVSeriesSearchInitialState();
}

class TVSeriesSearchLoadingState extends TVSeriesSearchState {
  const TVSeriesSearchLoadingState();
}

class TVSeriesSearchErrorState extends TVSeriesSearchState with EquatableMixin {
  const TVSeriesSearchErrorState(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  TVSeriesSearchErrorState copyWith({
    String? message,
  }) {
    return TVSeriesSearchErrorState(
      message ?? this.message,
    );
  }
}

class TVSeriesSearchLoadedState extends TVSeriesSearchState with EquatableMixin {
  const TVSeriesSearchLoadedState({
    required this.items,
  });

  final List<TV> items;

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;

  TVSeriesSearchLoadedState copyWith({
    List<TV>? items,
  }) {
    return TVSeriesSearchLoadedState(
      items: items ?? this.items,
    );
  }
}
