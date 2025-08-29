import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:utl_electrochemical_tester/domain/entity/electrochemical_entity.dart';
import 'package:utl_electrochemical_tester/domain/repository/electrochemical_entity_repository.dart';

class ElectrochemicalRinging {
  late final StreamSubscription<ElectrochemicalEntity> _entitySyncStream;
  @protected
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  bool _isStarting = false;
  ElectrochemicalRinging({
    required this.electrochemicalEntityRepository,
  }) {
    _entitySyncStream = electrochemicalEntityRepository.entitySyncStream.listen((entity) async {
      if(!_isStarting) return;
      if(entity.header.dataLength <= entity.data.length) {
        FlutterRingtonePlayer().playNotification();
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
    _entitySyncStream.cancel();
  }
}