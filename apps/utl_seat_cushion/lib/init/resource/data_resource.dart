import 'package:shared_preferences/shared_preferences.dart';
import 'package:utl_seat_cushion/domain/repository/seat_cushion_repository.dart';

class DataResource {
  DataResource._();
  static late final SharedPreferences sharedPreferences;
  static late final SeatCushionRepository seatCushionRepository;
}
