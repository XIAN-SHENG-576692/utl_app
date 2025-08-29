part of '../entity/electrochemical_entity.dart';

@CopyWith()
@HiveType(typeId: 2)
@JsonSerializable()
class ElectrochemicalData with EquatableMixin {
  @HiveField(0)
  final double data;

  const ElectrochemicalData({
    required this.data,
  });

  @override
  List<Object?> get props => [
    data,
  ];

  @override
  factory ElectrochemicalData.fromJson(Map<String, dynamic> json) => _$ElectrochemicalDataFromJson(json);

  Map<String, dynamic> toJson() => _$ElectrochemicalDataToJson(this);
}
