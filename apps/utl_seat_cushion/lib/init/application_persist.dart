import 'package:utl_seat_cushion/application/seat_cushion_sensor_data_handler.dart';
import 'package:utl_seat_cushion/init/resource/data_resource.dart';
import 'package:utl_seat_cushion/init/resource/service_resource.dart';

class ApplicationPersist {
  ApplicationPersist._();
  static void init() {
    seatCushionSensorDataHandler = SeatCushionSensorDataHandler(
      seatCushionSensorDataStream: ServiceResource.seatCushionSensorDataStream,
      seatCushionRepository: DataResource.seatCushionRepository,
    );
  }
  static late final SeatCushionSensorDataHandler seatCushionSensorDataHandler;
}
