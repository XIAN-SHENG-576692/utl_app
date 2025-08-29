import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utl_electrochemical_tester/domain/repository/electrochemical_entity_repository.dart';
import 'package:utl_electrochemical_tester/domain/usecase/process_electrochemical_entities_usecase.dart';

import '../../../../domain/entity/electrochemical_entity.dart';

class ElectrochemicalRepositorySyncChangeNotifier extends ChangeNotifier {
  final ElectrochemicalEntityRepository electrochemicalEntityRepository;
  late final StreamSubscription _addSubscription;
  late final StreamSubscription _removeSubscription;
  final List<ElectrochemicalEntity> _entities = [];
  List<ElectrochemicalEntity> get entities => _entities.toList(growable: false);
  ElectrochemicalRepositorySyncChangeNotifier({
    required bool initFetch,
    required this.electrochemicalEntityRepository,
  }) {
    _addSubscription = electrochemicalEntityRepository.entitySyncStream.listen((entity) {
      _upsert(entity);
    });
    _removeSubscription = electrochemicalEntityRepository.entityRemovedStream.listen((id) {
      _remove(id);
    });
    if(initFetch) {
      final usecase = ProcessElectrochemicalEntitiesUsecase(electrochemicalEntityRepository: electrochemicalEntityRepository);
      usecase(processor: (entity) {
        if(entity != null) _upsert(entity);
        return true;
      });
    }
  }
  final Lock _lock = Lock();
  void _upsert(ElectrochemicalEntity entity) {
    _lock.synchronized(() {
      final index = _entities.indexWhere((e) => e.id == entity.id);
      if(index != -1) {
        _entities[index] = entity;
      } else {
        _entities.add(entity);
      }
      notifyListeners();
    });
  }
  void _remove(int id) {
    _lock.synchronized(() {
      _entities.removeWhere((e) => e.id == id);
      notifyListeners();
    });
  }
  @override
  void dispose() {
    _addSubscription.cancel();
    _removeSubscription.cancel();
    super.dispose();
  }
}
