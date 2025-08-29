import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/entity/electrochemical_entity.dart';
import '../../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../../change_notifier/electrochemical/command/electrochemical_command_change_notifier.dart';
import '../../electrochemical_command_widget_builder.dart';

part 'ca.dart';
part 'cv.dart';
part 'dpv.dart';

class ElectrochemicalCommandTypeView extends StatelessWidget {
  final ElectrochemicalType type;
  const ElectrochemicalCommandTypeView                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ({
    super.key,
    required this.type,
  });
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ElectrochemicalType.ca:
        return _Ca();
      case ElectrochemicalType.cv:
        return _Cv();
      case ElectrochemicalType.dpv:
        return _Dpv();
    }
  }
}
