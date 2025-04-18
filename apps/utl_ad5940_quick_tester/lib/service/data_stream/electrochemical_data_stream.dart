import '../../domain/value/electrochemical_data.dart';
import '../../domain/value/electrochemical_header.dart';

class IdWithHeader {
  final int id;
  final ElectrochemicalHeader header;
  IdWithHeader({
    required this.id,
    required this.header,
  });
}

abstract class ElectrochemicalDataStream {
  Stream<IdWithHeader> get headerStream;
  Stream<ElectrochemicalData> get dataStream;
  Stream<void> get endStream;
}
