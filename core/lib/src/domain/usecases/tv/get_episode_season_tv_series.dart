import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/entities/tv/tv_episode.dart';
import '../../../domain/repositories/tv_repository.dart';

class GetEpisodeSeasonTVSeries {
  final TVRepository repository;

  GetEpisodeSeasonTVSeries({
    required this.repository,
  });
  Future<Either<Failure, List<Episode>>> execute({required int id, required int seasonNumber}) {
    return repository.getEpisodeSeasonTVSeries(
      id: id,
      seasonNumber: seasonNumber,
    );
  }
}
