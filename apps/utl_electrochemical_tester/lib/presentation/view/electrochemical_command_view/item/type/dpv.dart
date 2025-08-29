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
            initialValue: notifier.getDpvElectrochemicalParametersEBegin().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setDpvElectrochemicalParametersEBegin(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eEnd,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEEnd().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setDpvElectrochemicalParametersEEnd(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eStep,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEStep().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setDpvElectrochemicalParametersEStep(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.ePulse,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersEPulse().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setDpvElectrochemicalParametersEPulse(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.tPulse,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersTPulse().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setDpvElectrochemicalParametersTPulse(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.scanRate,
          body: TextFormField(
            initialValue: notifier.getDpvElectrochemicalParametersScanRate().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setDpvElectrochemicalParametersScanRate(double.tryParse(value) ?? 0.0),
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
