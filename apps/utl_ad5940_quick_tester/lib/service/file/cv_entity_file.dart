import 'package:common_utils/time_utils.dart';
import 'package:file_utils/csv/simple_csv_file.dart';
import 'package:utl_ad5940_quick_tester/domain/entity/electrochemical_entity.dart';

class CvEntityFile {
  final String dataName;
  final ElectrochemicalEntity entity;
  final String folderPath;
  CvEntityFile({
    required this.dataName,
    required this.entity,
    required this.folderPath,
  }) {
    final file = SimpleCsvFile(path: "$folderPath/AD5940_${dataName}_${entity.header.type}_${DateTime.now().toFileNameFormat()}.csv");
    _write(file);
  }
  _write(SimpleCsvFile file) async {
    await file.clear(bom: true, flush: true);
    await file.writeAsString(data: [
      dataName,
    ]);
    await file.writeAsString(data: [
      entity.header.createdTime.toString(),
    ]);
    await file.writeAsString(data: [
      entity.header.type.name,
    ]);
    for(final current in entity.header.cvParameters!
        .currents(
      adcData: entity.data.map((d) => d.adcData),
      adcPga: entity.header.adcPga,
      vRef1p82: entity.header.vRef1p82,
      hsRTia: entity.header.hsRTia,
    )) {
      await file.writeAsString(data: [
        current.toString(),
      ]);
    }
  }
}
