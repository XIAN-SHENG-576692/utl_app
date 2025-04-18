import 'package:common_utils/time_utils.dart';
import 'package:file_utils/csv/simple_csv_file.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utl_ad5940_quick_tester/domain/entity/electrochemical_entity.dart';

class AllEntitiesFile {
  final Lock _lock = Lock();
  final SimpleCsvFile _file;
  AllEntitiesFile({
    required String folderPath,
  }) : _file = SimpleCsvFile(path: "$folderPath/AD5940_${DateTime.now().toFileNameFormat()}.csv") {
    _lock.synchronized(() async {
      await _file.clear(bom: true, flush: true);
      await _file.writeAsString(data: [
        "id",
        "Device id",
        "Device name",
        "Data name",
        "Time",
        "Type",
        "Temperature",
        "Electrode Routing",
        "hsRTia.magnitude",
        "hsRTia.phase",
        "adcPga",
        "vRef1p82",
        "CA: E_dc",
        "CA: T_interval",
        "CA: T_run",
        "CV: E_begin",
        "CV: E_vertex1",
        "CV: E_vertex2",
        "CV: E_step",
        "CV: Scan Rate",
        "CV: Number of Scans",
        "DPV: E_begin",
        "DPV: E_end",
        "DPV: E_step",
        "DPV: E_pulse",
        "DPV: T_pulse",
        "DPV: Scan Rate",
        "DPV: Inversion Option",
        "ADC raw",
      ]);
    });
  }
  Future<bool> downloadAllElectrochemicalEntity({
    required String dataName,
    required ElectrochemicalEntity entity,
    required String folderPath,
  }) {
    return _lock.synchronized(() async {
      await _file.writeAsString(data: [
        entity.id.toString(),
        entity.header.deviceId,
        entity.header.deviceName,
        dataName,
        entity.header.createdTime.toString(),
        entity.header.type.name,
        entity.header.temperature.toString(),
        entity.header.electrodeRouting.fold("", (init, b) => init + b.toRadixString(16)),
        entity.header.hsRTia.magnitude.toString(),
        entity.header.hsRTia.phase.toString(),
        entity.header.adcPga.toString(),
        entity.header.vRef1p82.toString(),
        entity.header.caParameters?.eDc.toString() ?? "",
        entity.header.caParameters?.tInterval.toString() ?? "",
        entity.header.caParameters?.tRun.toString() ?? "",
        entity.header.cvParameters?.eBegin.toString() ?? "",
        entity.header.cvParameters?.eVertex1.toString() ?? "",
        entity.header.cvParameters?.eVertex2.toString() ?? "",
        entity.header.cvParameters?.eStep.toString() ?? "",
        entity.header.cvParameters?.scanRate.toString() ?? "",
        entity.header.cvParameters?.numberOfScans.toString() ?? "",
        entity.header.dpvParameters?.eBegin.toString() ?? "",
        entity.header.dpvParameters?.eEnd.toString() ?? "",
        entity.header.dpvParameters?.eStep.toString() ?? "",
        entity.header.dpvParameters?.ePulse.toString() ?? "",
        entity.header.dpvParameters?.tPulse.toString() ?? "",
        entity.header.dpvParameters?.scanRate.toString() ?? "",
        entity.header.dpvParameters?.inversionOption.name ?? "",
        ...entity.data.map((d) => d.adcData.toString()),
      ]);
      return true;
    });
  }
}
