import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetDetailTVSeries {
  final TVRepository repository;
  GetDetailTVSeries({
    required this.repository,
  });

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getDetailTVSeries(id);
  }
}
