import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_production_country_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry extends Equatable {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);

  @override
  List<Object> get props => [iso31661, name];

  @override
  bool get stringify => true;

  ProductionCountry copyWith({
    String? iso31661,
    String? name,
  }) {
    return ProductionCountry(
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
    );
  }
}
