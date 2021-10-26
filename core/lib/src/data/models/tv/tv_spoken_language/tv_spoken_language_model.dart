import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/tv/tv_spoken_language.dart';

part 'tv_spoken_language_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguageModel extends Equatable {
  const SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String? englishName;
  final String? iso6391;
  final String? name;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageModelFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguageModelToJson(this);
  SpokenLanguage toEntity() =>
      SpokenLanguage(englishName: englishName, iso6391: iso6391, name: name);
  @override
  List<Object?> get props => [englishName, iso6391, name];

  @override
  bool get stringify => true;
}
