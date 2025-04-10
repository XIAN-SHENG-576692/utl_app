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
            initialValue: notifier.getCaElectrochemicalParametersEDc(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCaElectrochemicalParametersEDc,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.tInterval,
          body: TextFormField(
            initialValue: notifier.getCaElectrochemicalParametersTInterval(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCaElectrochemicalParametersTInterval,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.tRun,
          body: TextFormField(
            initialValue: notifier.getCaElectrochemicalParametersTRun(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCaElectrochemicalParametersTRun,
          ),
        ),
      ],
    );
  }
}
