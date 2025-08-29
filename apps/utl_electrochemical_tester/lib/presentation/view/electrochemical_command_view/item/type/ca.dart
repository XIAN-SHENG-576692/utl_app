part of 'electrochemical_command_type_view.dart';

class _Ca extends StatelessWidget {
  const _Ca({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalCommandChangeNotifier>();
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eDc,
          body: TextFormField(
            initialValue: notifier.getCaElectrochemicalParametersEDc().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCaElectrochemicalParametersEDc(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.tInterval,
          body: TextFormField(
            initialValue: notifier.getCaElectrochemicalParametersTInterval().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCaElectrochemicalParametersTInterval(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.tRun,
          body: TextFormField(
            initialValue: notifier.getCaElectrochemicalParametersTRun().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCaElectrochemicalParametersTRun(double.tryParse(value) ?? 0.0),
          ),
        ),
      ],
    );
  }
}
