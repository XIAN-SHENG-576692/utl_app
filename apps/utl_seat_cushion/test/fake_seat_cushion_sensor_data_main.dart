import 'dart:async';

import 'package:utl_seat_cushion/init/resource/service_resource.dart';
import 'package:utl_seat_cushion/main.dart' as home;

import 'data/fake_data_generator.dart';

Future<void> main() async {
  await home.main();
  final fakeDataGenerator = FakeDataGenerator();
  Timer.periodic(const Duration(milliseconds: 10), (timer) {
    ServiceResource.seatCushionSensorDataStream.mockData(data: fakeDataGenerator.createFakeSeatCushionSensorData());
  });
}
