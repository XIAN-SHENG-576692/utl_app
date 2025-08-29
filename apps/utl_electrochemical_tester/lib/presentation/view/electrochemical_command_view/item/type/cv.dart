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
            initialValue: notifier.getCvElectrochemicalParametersEBegin().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCvElectrochemicalParametersEBegin(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eVertex1,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersEVertex1().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCvElectrochemicalParametersEVertex1(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eVertex2,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersEVertex2().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCvElectrochemicalParametersEVertex2(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.eStep,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersEStep().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCvElectrochemicalParametersEStep(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.scanRate,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersScanRate().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCvElectrochemicalParametersScanRate(double.tryParse(value) ?? 0.0),
          ),
        ),

        ElectrochemicalCommandWidgetBuilder.buildTile(
          label: appLocalizations.numberOfScans,
          body: TextFormField(
            initialValue: notifier.getCvElectrochemicalParametersNumberOfScans().toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) => notifier.setCvElectrochemicalParametersNumberOfScans(int.tryParse(value) ?? 0),
          ),
        ),
      ],
    );
  }
}
