import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:utl_electrochemical_tester/presentation/change_notifier/electrochemical/command/_.dart';

abstract class ElectrochemicalCommandChangeNotifier
    with AD5940,
    Title,
    Ca,
    Cv,
    Dpv
    implements ChangeNotifier  {
}
