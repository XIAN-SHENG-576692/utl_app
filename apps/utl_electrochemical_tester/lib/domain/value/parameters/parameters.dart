part of '../../entity/electrochemical_entity.dart';

abstract class ElectrochemicalParameters {
  ElectrochemicalType get type;
  bool get isValid;
  int get dataLength;
  Map<String, dynamic> toJson();
}
