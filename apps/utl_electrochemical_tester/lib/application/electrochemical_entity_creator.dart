import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/domain/repository/electrochemical_entity_repository.dart';
import 'package:utl_electrochemical_tester/service/electrochemical/electrochemical_data_stream.dart';

class ElectrochemicalEntityCreator {
  late final StreamSubscription<ElectrochemicalHeader> _headerStream;
  late final StreamSubscription<ElectrochemicalData> _dataStream;
  @protected
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  bool _isStarting = false;
  ElectrochemicalEntityCreator({
    required this.electrochemicalEntityRepository,
    required ElectrochemicalStreamer electrochemicalDataStream,
  }) {
    _headerStream = electrochemicalDataStream.headerStream.listen((header) {
      if(!_isStarting) return;
      electrochemicalEntityRepository.createEntityFromHeader(
        header: header,
      );
    });
    _dataStream = electrochemicalDataStream.dataStream.listen((data) async {
      if(!_isStarting) return;
      await for (var entityId in electrochemicalEntityRepository
          .fetchEntities()
          .where((e) => e.id == data.entityId)
          .map((e) => e.id)
      ) {
        electrochemicalEntityRepository.upsertDataToEntity(
          entityId: entityId,
          index: data.index,
          data: data,
        );
      }
    });
  }
  void start() {
    _isStarting = true;
  }
  void stop() {
    _isStarting = false;
  }
  void dispose() {
    _headerStream.cancel();
    _dataStream.cancel();
  }
}
