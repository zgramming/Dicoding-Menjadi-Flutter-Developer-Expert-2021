import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SearchTVSeries {
  final TVRepository repository;
  SearchTVSeries({
    required this.repository,
  });

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTVSeries(query);
  }
}
