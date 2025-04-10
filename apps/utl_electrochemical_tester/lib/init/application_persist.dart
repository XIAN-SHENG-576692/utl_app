import 'package:utl_electrochemical_tester/application/electrochemical_entity_creator.dart';
import 'package:utl_electrochemical_tester/init/resource/service/service_resource.dart';
import 'package:utl_electrochemical_tester/init/resource/data/repository_resource.dart';

class ApplicationPersist {
  ApplicationPersist._();
  static void init() {
    electrochemicalEntityCreator = ElectrochemicalEntityCreator(
      electrochemicalEntityRepository: RepositoryResource.electrochemicalEntityRepository,
      electrochemicalDataStream: ServiceResource.electrochemicalDataStream,
    );
  }
  static late final ElectrochemicalEntityCreator electrochemicalEntityCreator;
}
