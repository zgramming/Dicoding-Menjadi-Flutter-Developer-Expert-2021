import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_last_episode_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class LastEpisodeToAir extends Equatable {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final DateTime airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);
  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);

  @override
  List<Object> get props {
    return [
      airDate,
      episodeNumber,
      id,
      name,
      overview,
      productionCode,
      seasonNumber,
      stillPath,
      voteAverage,
      voteCount,
    ];
  }

  @override
  bool get stringify => true;

  LastEpisodeToAir copyWith({
    DateTime? airDate,
    int? episodeNumber,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? seasonNumber,
    String? stillPath,
    double? voteAverage,
    int? voteCount,
  }) {
    return LastEpisodeToAir(
      airDate: airDate ?? this.airDate,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      productionCode: productionCode ?? this.productionCode,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      stillPath: stillPath ?? this.stillPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}
