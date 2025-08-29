import 'dart:math';

import 'package:file_utils/csv/simple_csv_file.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

import '../../../l10n/gen_l10n/app_localizations.dart';

class CsvLineChartElectrochemicalFile {
  static String _generateTimeString() {
    DateTime t = DateTime.now();
    return "${t.year.toString().padLeft(2, '0')}"
        "-${t.month.toString().padLeft(2, '0')}"
        "-${t.day.toString().padLeft(2, '0')}"
        "_${t.hour.toString().padLeft(2, '0')}"
        "-${t.minute.toString().padLeft(2, '0')}"
        "-${t.second.toString().padLeft(2, '0')}"
        "_${t.millisecond.toString().padLeft(3, '0')}"
        "${t.microsecond.toString().padLeft(3, '0')}";
  }

  final Lock _lock = Lock();
  final SimpleCsvFile _file;
  CsvLineChartElectrochemicalFile({
    required String folderPath,
  }) : _file = SimpleCsvFile(
    path: "$folderPath/LineChart_${_generateTimeString()}.csv",
  );

  Future<bool> clear() {
    return _lock.synchronized(() async {
      try {
        await _file.clear(bom: true);
        return true;
      } catch(e) {
        return false;
      }
    });
  }

  Future<bool> writeEntities({
    required AppLocalizations appLocalizations,
    required Iterable<ElectrochemicalEntity> entities,
  }) {
    return _lock.synchronized(() async {
      await _file.writeAsString(data: ["id", ...entities.map((e) => e.id.toString())]);
      await _file.writeAsString(data: [appLocalizations.name, ...entities.map((e) => e.header.dataName)]);
      await _file.writeAsString(data: ["address", ...entities.map((e) => e.header.deviceId)]);
      await _file.writeAsString(data: [appLocalizations.time, ...entities.map((e) => e.header.createdTime.toString())]);
      await _file.writeAsString(data: [appLocalizations.type, ...entities.map((e) => e.header.type.name)]);
      await _file.writeAsString(data: [appLocalizations.temperature, ...entities.map((e) => e.header.temperature.toString())]);

      await _file.writeAsString(data: ["${appLocalizations.ca}: ${appLocalizations.eDc}", ...entities.map((e) => e.header.caParameters?.eDc.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.ca}: ${appLocalizations.tInterval}", ...entities.map((e) => e.header.caParameters?.tInterval.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.ca}: ${appLocalizations.tRun}", ...entities.map((e) => e.header.caParameters?.tRun.toString() ?? "")]);

      await _file.writeAsString(data: ["${appLocalizations.cv}: ${appLocalizations.eBegin}", ...entities.map((e) => e.header.cvParameters?.eBegin.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.cv}: ${appLocalizations.eVertex1}", ...entities.map((e) => e.header.cvParameters?.eVertex1.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.cv}: ${appLocalizations.eVertex2}", ...entities.map((e) => e.header.cvParameters?.eVertex2.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.cv}: ${appLocalizations.eStep}", ...entities.map((e) => e.header.cvParameters?.eStep.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.cv}: ${appLocalizations.scanRate}", ...entities.map((e) => e.header.cvParameters?.scanRate.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.cv}: ${appLocalizations.numberOfScans}", ...entities.map((e) => e.header.cvParameters?.numberOfScans.toString() ?? "")]);

      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.eBegin}", ...entities.map((e) => e.header.dpvParameters?.eBegin.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.eEnd}", ...entities.map((e) => e.header.dpvParameters?.eEnd.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.eStep}", ...entities.map((e) => e.header.dpvParameters?.eStep.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.ePulse}", ...entities.map((e) => e.header.dpvParameters?.ePulse.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.tPulse}", ...entities.map((e) => e.header.dpvParameters?.tPulse.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.scanRate}", ...entities.map((e) => e.header.dpvParameters?.scanRate.toString() ?? "")]);
      await _file.writeAsString(data: ["${appLocalizations.dpv}: ${appLocalizations.inversionOption}", ...entities.map((e) => e.header.dpvParameters?.inversionOption.name ?? "")]);
      int index = 0;
      await _file.writeAsString(data: []);
      while(index < entities.fold(0, (prev, entity) => max(prev, entity.data.length))) {
        await _file.writeAsString(data: [index.toString(), ...entities.map((e) {
          if(index < e.data.length) return (e.data[index].data * 1e9).toString();
          return "";
        })]);
        index++;
      }
      return true;
    });
  }
}
