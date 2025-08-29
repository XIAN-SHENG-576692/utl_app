import 'dart:convert';
import 'dart:io';

import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';

class JsonElectrochemicalFile {
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
  final File _file;
  JsonElectrochemicalFile({
    required String folderPath,
  }) : _file = File(
    "$folderPath/Json_${_generateTimeString()}.json",
  );

  Future<bool> writeEntities({
    required Iterable<ElectrochemicalEntity> entities,
  }) {
    return _lock.synchronized(() async {
      await _file.writeAsString(
        entities.jsonEncode(),
        mode: FileMode.write,
        encoding: utf8,
        flush: true,
      );
      return true;
    });
  }
}
