import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
