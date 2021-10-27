import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:search/search.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
