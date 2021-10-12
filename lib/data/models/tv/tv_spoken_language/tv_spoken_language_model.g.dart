// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_spoken_language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['english_name'] as String,
      iso6391: json['iso6391'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso6391': instance.iso6391,
      'name': instance.name,
    };
