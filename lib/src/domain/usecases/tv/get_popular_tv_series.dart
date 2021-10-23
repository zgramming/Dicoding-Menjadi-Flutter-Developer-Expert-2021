import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetPopularTVSeries {
  final TVRepository repository;

  GetPopularTVSeries({
    required this.repository,
  });
  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTVSeries();
  }
}
