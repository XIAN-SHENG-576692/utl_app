import 'package:file_utils/csv/simple_csv_file.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

import '../../../l10n/gen_l10n/app_localizations.dart';

class CsvRowElectrochemicalFile {
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
  CsvRowElectrochemicalFile({
    required String folderPath,
  }) : _file = SimpleCsvFile(
    path: "$folderPath/Row_${_generateTimeString()}.csv",
  );

  Future<bool> clearThenGenerateHeader({
    required AppLocalizations appLocalizations,
  }) {
    return _lock.synchronized(() async {
      try {
        await _file.clear(bom: true);
        await _file.writeAsString(
          data: [
            "id",
            appLocalizations.name,
            "address",
            appLocalizations.time,
            appLocalizations.type,
            appLocalizations.temperature,
            "${appLocalizations.ca}: ${appLocalizations.eDc}",
            "${appLocalizations.ca}: ${appLocalizations.tInterval}",
            "${appLocalizations.ca}: ${appLocalizations.tRun}",
            "${appLocalizations.cv}: ${appLocalizations.eBegin}",
            "${appLocalizations.cv}: ${appLocalizations.eVertex1}",
            "${appLocalizations.cv}: ${appLocalizations.eVertex2}",
            "${appLocalizations.cv}: ${appLocalizations.eStep}",
            "${appLocalizations.cv}: ${appLocalizations.scanRate}",
            "${appLocalizations.cv}: ${appLocalizations.numberOfScans}",
            "${appLocalizations.dpv}: ${appLocalizations.eBegin}",
            "${appLocalizations.dpv}: ${appLocalizations.eEnd}",
            "${appLocalizations.dpv}: ${appLocalizations.eStep}",
            "${appLocalizations.dpv}: ${appLocalizations.ePulse}",
            "${appLocalizations.dpv}: ${appLocalizations.tPulse}",
            "${appLocalizations.dpv}: ${appLocalizations.scanRate}",
            "${appLocalizations.dpv}: ${appLocalizations.inversionOption}",
            appLocalizations.current,
          ],
        );
        return true;
      } catch(e) {
        return false;
      }
    });
  }

  Future<bool> writeEntities({
    required Iterable<ElectrochemicalEntity> entities,
  }) {
    return _lock.synchronized(() async {
      for (var entity in entities) {
        var header = entity.header;
        await _file.writeAsString(
          data: [
            entity.id.toString(),
            header.dataName,
            header.deviceId,
            header.createdTime.toString(),
            header.type.name,
            header.temperature.toString(),

            header.caParameters?.eDc.toString() ?? "",
            header.caParameters?.tInterval.toString() ?? "",
            header.caParameters?.tRun.toString() ?? "",

            header.cvParameters?.eBegin.toString() ?? "",
            header.cvParameters?.eVertex1.toString() ?? "",
            header.cvParameters?.eVertex2.toString() ?? "",
            header.cvParameters?.eStep.toString() ?? "",
            header.cvParameters?.scanRate.toString() ?? "",
            header.cvParameters?.numberOfScans.toString() ?? "",

            header.dpvParameters?.eBegin.toString() ?? "",
            header.dpvParameters?.eEnd.toString() ?? "",
            header.dpvParameters?.eStep.toString() ?? "",
            header.dpvParameters?.ePulse.toString() ?? "",
            header.dpvParameters?.tPulse.toString() ?? "",
            header.dpvParameters?.scanRate.toString() ?? "",
            header.dpvParameters?.inversionOption.name ?? "",

            ...entity.data.map((e) => (e.data * 1e9).toString()),
          ],
        );
      }
      return true;
    });
  }
}
