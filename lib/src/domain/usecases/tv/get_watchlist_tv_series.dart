import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/tv/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetWatchlistTVSeries {
  final TVRepository repository;
  GetWatchlistTVSeries({
    required this.repository,
  });

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getWatchlistTVSeries();
  }
}
