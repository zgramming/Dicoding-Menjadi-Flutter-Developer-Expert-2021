import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class SearchTVSeries {
  final TVRepository repository;
  SearchTVSeries({
    required this.repository,
  });

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTVSeries(query);
  }
}
