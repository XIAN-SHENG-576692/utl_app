import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../service/electrochemical/dto/ad5940_parameters.dart';
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
          label: appLocalizations.ad5940ParametersElectrochemicalWorkingElectrode,
          body: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<Ad5940ParametersElectrochemicalWorkingElectrode>(
                value: notifier.getAd5940ParametersElectrochemicalWorkingElectrode(),
                onChanged: (newValue) {
                  setState(() {
                    notifier.setAd5940ParametersElectrochemicalWorkingElectrode(newValue!);
                  });
                },
                items: Ad5940ParametersElectrochemicalWorkingElectrode.values.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option.name),
                  );
                }).toList(),
              );
            },
          ),
        ),
        // ElectrochemicalCommandWidgetBuilder.buildTile(
        //   label: appLocalizations.ad5940HsRTia,
        //   body: StatefulBuilder(
        //     builder: (context, setState) {
        //       return DropdownButton<Ad5940ParametersHsTiaRTia>(
        //         value: electrochemicalCommandController.getAd5940ParametersHsTiaRTia(),
        //         onChanged: (newValue) {
        //           setState(() {
        //             electrochemicalCommandController.setAd5940ParametersHsTiaRTia(newValue!);
        //           });
        //         },
        //         items: Ad5940ParametersHsTiaRTia.values.map((option) {
        //           return DropdownMenuItem(
        //             value: option,
        //             child: Text(option.name),
        //           );
        //         }).toList(),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
