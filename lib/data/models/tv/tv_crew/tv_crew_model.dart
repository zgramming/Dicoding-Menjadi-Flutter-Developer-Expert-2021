import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ditonton/domain/entities/tv/tv_crew.dart';

part 'tv_crew_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class CrewModel extends Equatable {
  const CrewModel({
    this.job,
    this.department,
    this.personId,
    this.creditId,
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    this.order,
  });

  final String? job;
  final String? department;
  final String? personId;
  final String? creditId;
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? character;
  final int? order;

  factory CrewModel.fromJson(Map<String, dynamic> json) => _$CrewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CrewModelToJson(this);
  Crew toEntity() {
    return Crew(
      id: id,
      job: job,
      department: department,
      personId: personId,
      creditId: creditId,
      adult: adult,
      gender: gender,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath,
      character: character,
      order: order,
    );
  }

  @override
  List<Object?> get props {
    return [
      job,
      department,
      personId,
      creditId,
      adult,
      gender,
      id,
      knownForDepartment,
      name,
      originalName,
      popularity,
      profilePath,
      character,
      order,
    ];
  }

  @override
  bool get stringify => true;

  CrewModel copyWith({
    String? job,
    String? department,
    String? personId,
    String? creditId,
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    String? character,
    int? order,
  }) {
    return CrewModel(
      job: job ?? this.job,
      department: department ?? this.department,
      personId: personId ?? this.personId,
      creditId: creditId ?? this.creditId,
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      character: character ?? this.character,
      order: order ?? this.order,
    );
  }
}
