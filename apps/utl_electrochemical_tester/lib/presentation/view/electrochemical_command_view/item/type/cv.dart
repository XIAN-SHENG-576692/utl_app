part of 'electrochemical_command_type_view.dart';

class _Cv extends StatelessWidget {
  const _Cv({
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
            initialValue: notifier.getCvElectrochemicalParametersEBegin(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCvElectrochemicalParametersEBegin,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eVertex1,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersEVertex1(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCvElectrochemicalParametersEVertex1,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eVertex2,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersEVertex2(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCvElectrochemicalParametersEVertex2,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eStep,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersEStep(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCvElectrochemicalParametersEStep,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.scanRate,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersScanRate(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCvElectrochemicalParametersScanRate,
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.numberOfScans,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersNumberOfScans(),
            keyboardType: TextInputType.number,
            onChanged: notifier.setCvElectrochemicalParametersNumberOfScans,
          ),
        ),
      ],
    );
  }
}
