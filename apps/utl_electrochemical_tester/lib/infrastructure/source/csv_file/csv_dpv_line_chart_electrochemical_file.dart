import 'dart:math';

import 'package:file_utils/csv/simple_csv_file.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

import '../../../l10n/gen_l10n/app_localizations.dart';

class CsvDpvLineChartElectrochemicalFile {
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
  CsvDpvLineChartElectrochemicalFile({
    required String folderPath,
  }) : _file = SimpleCsvFile(
    path: "$folderPath/DpvLineChart_${_generateTimeString()}.csv",
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
    Iterable<ElectrochemicalEntity> dpvEntities = entities.where((e) => e.header.type == ElectrochemicalType.dpv);
    return _lock.synchronized(() async {
      await _file.writeAsString(data: ["id", ...dpvEntities.map((e) => e.id.toString())]);
      await _file.writeAsString(data: [appLocalizations.name, ...dpvEntities.map((e) => e.header.dataName)]);
      await _file.writeAsString(data: ["address", ...dpvEntities.map((e) => e.header.deviceId)]);
      await _file.writeAsString(data: [appLocalizations.time, ...dpvEntities.map((e) => e.header.createdTime.toString())]);
      await _file.writeAsString(data: [appLocalizations.type, ...dpvEntities.map((e) => e.header.type.name)]);
      await _file.writeAsString(data: [appLocalizations.temperature, ...dpvEntities.map((e) => e.header.temperature.toString())]);

      await _file.writeAsString(data: [(appLocalizations.eBegin), ...dpvEntities.map((e) => e.header.dpvParameters?.eBegin.toString() ?? "")]);
      await _file.writeAsString(data: [(appLocalizations.eEnd), ...dpvEntities.map((e) => e.header.dpvParameters?.eEnd.toString() ?? "")]);
      await _file.writeAsString(data: [(appLocalizations.eStep), ...dpvEntities.map((e) => e.header.dpvParameters?.eStep.toString() ?? "")]);
      await _file.writeAsString(data: [(appLocalizations.ePulse), ...dpvEntities.map((e) => e.header.dpvParameters?.ePulse.toString() ?? "")]);
      await _file.writeAsString(data: [(appLocalizations.tPulse), ...dpvEntities.map((e) => e.header.dpvParameters?.tPulse.toString() ?? "")]);
      await _file.writeAsString(data: [(appLocalizations.scanRate), ...dpvEntities.map((e) => e.header.dpvParameters?.scanRate.toString() ?? "")]);
      await _file.writeAsString(data: [(appLocalizations.inversionOption), ...dpvEntities.map((e) => e.header.dpvParameters?.inversionOption.name ?? "")]);
      int index = 0;
      await _file.writeAsString(data: []);
      while(index < dpvEntities.fold(0, (prev, entity) => max(prev, entity.dvpCurrents.length))) {
        await _file.writeAsString(data: [index.toString(), ...dpvEntities.map((e) {
          if(index < e.dvpCurrents.length) return (e.dvpCurrents.elementAt(index) * 1e9).toString();
          return "";
        })]);
        index++;
      }
      return true;
    });
  }
}
