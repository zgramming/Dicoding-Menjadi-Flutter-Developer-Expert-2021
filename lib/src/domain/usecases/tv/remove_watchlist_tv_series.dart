import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class RemoveWatchlistTVSeries {
  final TVRepository repository;
  RemoveWatchlistTVSeries({
    required this.repository,
  });

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeWatchlistTVSeries(tv);
  }
}
