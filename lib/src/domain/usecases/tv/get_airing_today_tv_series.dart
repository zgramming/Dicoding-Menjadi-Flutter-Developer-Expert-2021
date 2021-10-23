import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetAiringTodayTVSeries {
  final TVRepository repository;
  const GetAiringTodayTVSeries({
    required this.repository,
  });

  Future<Either<Failure, List<TV>>> execute() async {
    return repository.getAiringTodayTVSeries();
  }
}
