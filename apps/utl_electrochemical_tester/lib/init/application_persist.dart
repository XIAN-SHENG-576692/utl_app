import 'package:utl_electrochemical_tester/application/electrochemical_entity_creator.dart';
import 'package:utl_electrochemical_tester/init/resource/service/service_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/data/repository_resource.dart';

import '../application/electrochemical_ringing.dart';

class ApplicationPersist {
  ApplicationPersist._();
  static void init() {
    electrochemicalEntityCreator = ElectrochemicalEntityCreator(
      electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
      electrochemicalDataStream: ServiceResource.electrochemicalDataStream,
    );
    electrochemicalRinging = ElectrochemicalRinging(
      electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
    );
  }
  static late final ElectrochemicalEntityCreator electrochemicalEntityCreator;
  static late final ElectrochemicalRinging electrochemicalRinging;
}
