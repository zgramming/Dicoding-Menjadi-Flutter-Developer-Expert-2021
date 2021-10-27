import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistTVSeries {
  final TVRepository repository;
  GetWatchlistTVSeries({
    required this.repository,
  });

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getWatchlistTVSeries();
  }
}
