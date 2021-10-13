import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ditonton/data/models/tv/tv_crew/tv_crew_model.dart';

part 'tv_episode_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class EpisodeModel extends Equatable {
  const EpisodeModel({
    this.airDate,
    this.episodeNumber,
    required this.crew,
    required this.guestStars,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  final DateTime? airDate;
  final int? episodeNumber;
  final List<CrewModel> crew;
  final List<CrewModel> guestStars;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => _$EpisodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);
  Episode toEntity() {
    return Episode(
      airDate: airDate,
      episodeNumber: episodeNumber,
      crew: crew.map((e) => e.toEntity()).toList(),
      guestStars: guestStars.map((e) => e.toEntity()).toList(),
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      airDate,
      episodeNumber,
      crew,
      guestStars,
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

  EpisodeModel copyWith({
    DateTime? airDate,
    int? episodeNumber,
    List<CrewModel>? crew,
    List<CrewModel>? guestStars,
    int? id,
    String? name,
    String? overview,
    String? productionCode,
    int? seasonNumber,
    String? stillPath,
    double? voteAverage,
    int? voteCount,
  }) {
    return EpisodeModel(
      airDate: airDate ?? this.airDate,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      crew: crew ?? this.crew,
      guestStars: guestStars ?? this.guestStars,
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
