import 'dart:typed_data';

import 'package:common_utils/bytes.dart';
import 'package:common_utils/string.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/command/electrochemical_command_change_notifier.dart';
import '../electrochemical_command_widget_builder.dart';

class ElectrochemicalCommandAd5940View extends StatelessWidget {
  const ElectrochemicalCommandAd5940View({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalCommandChangeNotifier>();
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.ad5940ParameterElectrodes,
          body: TextFormField(
            initialValue: notifier.getAd5940ParametersElectrodes().toByteStrings().join(""),
            keyboardType: TextInputType.number,
            onChanged: (s) => notifier.setAd5940ParametersElectrodes(s.hexToUint8List()),
          ),
        ),
      ],
    );
  }
}
