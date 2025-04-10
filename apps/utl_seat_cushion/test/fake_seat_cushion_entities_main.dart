import 'dart:async';

import 'package:utl_seat_cushion/init/resource/data_resource.dart';
import 'package:utl_seat_cushion/main.dart' as home;

import 'data/fake_data_generator.dart';

Future<void> main() async {
  await home.main();
  final fakeDataGenerator = FakeDataGenerator();
  Timer.periodic(const Duration(milliseconds: 10), (timer) async {
    DataResource.seatCushionRepository.add(entity: await fakeDataGenerator.createFakeSeatCushionEntity());
  });
}
