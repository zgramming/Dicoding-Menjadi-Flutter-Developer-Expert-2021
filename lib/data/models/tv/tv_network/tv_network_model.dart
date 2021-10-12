import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_network_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class Network extends Equatable {
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  final String name;
  final int id;
  final String logoPath;
  final String originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkToJson(this);

  @override
  List<Object> get props => [name, id, logoPath, originCountry];

  @override
  bool get stringify => true;

  Network copyWith({
    String? name,
    int? id,
    String? logoPath,
    String? originCountry,
  }) {
    return Network(
      name: name ?? this.name,
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      originCountry: originCountry ?? this.originCountry,
    );
  }
}
