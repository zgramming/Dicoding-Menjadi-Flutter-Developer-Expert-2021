import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_season_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class Season extends Equatable {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  @override
  List<Object> get props {
    return [
      airDate,
      episodeCount,
      id,
      name,
      overview,
      posterPath,
      seasonNumber,
    ];
  }

  @override
  bool get stringify => true;

  Season copyWith({
    DateTime? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
  }) {
    return Season(
      airDate: airDate ?? this.airDate,
      episodeCount: episodeCount ?? this.episodeCount,
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
    );
  }
}
