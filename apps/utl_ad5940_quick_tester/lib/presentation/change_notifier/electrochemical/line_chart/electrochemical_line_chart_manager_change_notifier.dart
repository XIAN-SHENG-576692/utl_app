import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../application/buffer_and_download_file.dart';
import '../../../../domain/entity/electrochemical_entity.dart';
import 'electrochemical_line_chart_change_notifier.dart';

class ElectrochemicalLineChartManagerChangeNotifier extends ChangeNotifier {
  late final StreamSubscription _upsertSubscription;
  final Set<ElectrochemicalEntity> _entities = {};
  Iterable<ElectrochemicalEntity> get entities => _entities;
  ElectrochemicalLineChartType _typeShow = ElectrochemicalLineChartType.ca;
  ElectrochemicalLineChartType get typeShow => _typeShow;
  selectTypeShow(ElectrochemicalLineChartType type) {
    if(_typeShow == type) return;
    _typeShow = type;
    notifyListeners();
  }
  ElectrochemicalLineChartManagerChangeNotifier({
    required BufferAndDownloadFile bufferAndDownloadFile,
  }) {
    _upsertSubscription = bufferAndDownloadFile.entityUpsertStream.listen((entity) {
      if(entity != null && !_entities.contains(entity)) _entities.add(entity);
      notifyListeners();
    });
  }
  void clearSeries() {
    _entities.clear();
    notifyListeners();
  }
  @override
  void dispose() {
    _upsertSubscription.cancel();
    super.dispose();
  }
}
