import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetRecommendationTVSeries {
  final TVRepository repository;

  GetRecommendationTVSeries({
    required this.repository,
  });
  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getRecommendationTVSeries(id);
  }
}
