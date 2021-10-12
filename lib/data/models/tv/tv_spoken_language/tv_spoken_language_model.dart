import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_spoken_language_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage extends Equatable {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);
  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  @override
  List<Object> get props => [englishName, iso6391, name];

  @override
  bool get stringify => true;

  SpokenLanguage copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) {
    return SpokenLanguage(
      englishName: englishName ?? this.englishName,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
    );
  }
}
