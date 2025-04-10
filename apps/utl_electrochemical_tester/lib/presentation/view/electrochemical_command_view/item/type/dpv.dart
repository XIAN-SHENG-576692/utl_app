part of 'electrochemical_command_type_view.dart';

class _Dpv extends StatelessWidget {
  const _Dpv({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalCommandChangeNotifier>();
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eBegin,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEBegin(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setDpvElectrochemicalParametersEBegin,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eEnd,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEEnd(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setDpvElectrochemicalParametersEEnd,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eStep,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEStep(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setDpvElectrochemicalParametersEStep,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.ePulse,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEPulse(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setDpvElectrochemicalParametersEPulse,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.tPulse,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersTPulse(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setDpvElectrochemicalParametersTPulse,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.scanRate,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersScanRate(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setDpvElectrochemicalParametersScanRate,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.inversionOption,
          body: StatefulBuilder(
            builder: (context, setState) {
              return DropdownButton<DpvElectrochemicalParametersInversionOption>(
                value: notifier.getDpvElectrochemicalParametersInversionOption(),
                onChanged: (newValue) {
                  setState(() {
                    notifier.setDpvElectrochemicalParametersInversionOption(newValue!);
                  });
                },
                items: DpvElectrochemicalParametersInversionOption.values.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option.name),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
