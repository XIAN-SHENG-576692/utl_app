import 'package:equatable/equatable.dart';

import '../value/electrochemical_data.dart';
import '../value/electrochemical_header.dart';

class ElectrochemicalEntity with EquatableMixin {

  ElectrochemicalEntity({
    required this.id,
    required this.header,
    required this.data,
  });

  final int id;
  final ElectrochemicalHeader header;
  final List<ElectrochemicalData> data;

  @override
  List<Object?> get props => [id];
}
