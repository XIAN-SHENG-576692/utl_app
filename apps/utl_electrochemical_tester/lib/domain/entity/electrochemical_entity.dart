import 'dart:convert' as convert;
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part '../value/electrochemical_data.dart';
part '../value/electrochemical_header.dart';
part '../value/parameters/parameters.dart';
part '../value/parameters/ca.dart';
part '../value/parameters/cv.dart';
part '../value/parameters/dpv.dart';

part 'electrochemical_entity.g.dart';

extension ElectrochemicalAggregate on Iterable<ElectrochemicalEntity> {
  Iterable<Map<String, dynamic>> toJson() => map((entity) => entity.toJson());
  String jsonEncode() => "[${map((entity) => convert.jsonEncode(entity.toJson())).join(",")}]";
}

extension ElectrochemicalAggregateString on String {
  Iterable<ElectrochemicalEntity> jsonDecode() => (convert.jsonDecode(this) as Iterable<dynamic>).map((e) => ElectrochemicalEntity.fromJson(e));
}

extension ElectrochemicalEntityLogic on ElectrochemicalEntity {
  /// Calculate average current
  double get averageCurrent => data.isEmpty
      ? 0
      : data.map((d) => d.data).reduce((value, element) => value + element) / data.length;

  /// Calculate maximum current
  double get maxCurrent => data.isEmpty ? 0 : data.map((d) => d.data).reduce((a, b) => a > b ? a : b);

  /// Calculate minimum current
  double get minCurrent => data.isEmpty ? 0 : data.map((d) => d.data).reduce((a, b) => a < b ? a : b);

  Iterable<double> get currents sync* {
    switch(header.type) {
      case ElectrochemicalType.ca:
      case ElectrochemicalType.cv:
      case ElectrochemicalType.dpv:
        for(final current in data.map((d) => d.data)) {
          yield current;
        }
      default:
        throw Exception("dvpCurrents: Only for CA, CV, DPV");
    }
  }

  Iterable<double> get dvpCurrents sync* {
    switch(header.type) {
      case ElectrochemicalType.dpv:
        for(var i = 1; i < data.length; i += 2) {
          yield data[i].data - data[i - 1].data;
        }
      default:
        throw Exception("dvpCurrents: Only for DPV");
    }
  }
}

@CopyWith()
@HiveType(typeId: 0)
@JsonSerializable()
class ElectrochemicalEntity with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final ElectrochemicalHeader header;
  @HiveField(2)
  final List<ElectrochemicalData> data;

  ElectrochemicalEntity({
    required this.id,
    required this.header,
    required this.data,
  });

  @override
  List<Object?> get props => [
    id,
    header,
    data,
  ];

  @override
  factory ElectrochemicalEntity.fromJson(Map<String, dynamic> json) => _$ElectrochemicalEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ElectrochemicalEntityToJson(this);
}
