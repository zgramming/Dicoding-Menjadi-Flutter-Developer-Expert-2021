import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class SaveWatchlistTVSeries {
  final TVRepository repository;
  SaveWatchlistTVSeries({
    required this.repository,
  });

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.insertWatchlistTVSeries(tv);
  }
}
