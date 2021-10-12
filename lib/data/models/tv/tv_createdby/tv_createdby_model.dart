import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_createdby_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy extends Equatable {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String profilePath;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);
  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      creditId,
      name,
      gender,
      profilePath,
    ];
  }

  @override
  bool get stringify => true;

  CreatedBy copyWith({
    int? id,
    String? creditId,
    String? name,
    int? gender,
    String? profilePath,
  }) {
    return CreatedBy(
      id: id ?? this.id,
      creditId: creditId ?? this.creditId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      profilePath: profilePath ?? this.profilePath,
    );
  }
}
