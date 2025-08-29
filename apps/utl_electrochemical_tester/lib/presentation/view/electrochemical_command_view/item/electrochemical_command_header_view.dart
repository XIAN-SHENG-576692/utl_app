import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utl_electrochemical_tester/presentation/theme/theme_data.dart';

import '../../../../domain/entity/electrochemical_entity.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/command/electrochemical_command_change_notifier.dart';

class ElectrochemicalCommandHeaderView extends StatelessWidget {
  final ElectrochemicalType type;
  const ElectrochemicalCommandHeaderView({
    super.key,
    required this.type,
  });
  String getTitle(AppLocalizations appLocalizations) {
    switch (type) {
      case ElectrochemicalType.ca:
        return appLocalizations.ca;
      case ElectrochemicalType.cv:
        return appLocalizations.cv;
      case ElectrochemicalType.dpv:
        return appLocalizations.dpv;
    }
  }
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalCommandChangeNotifier>();
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final title = getTitle(appLocalizations);
    return ListTile(
      leading: Text(title),
      title: TextFormField(
        initialValue: notifier.getDataNameBuffer(),
        onChanged: notifier.setDataNameBuffer,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => notifier.start(type: type),
            icon: const Icon(Icons.send),
          ),
          IconButton(
            onPressed: () => notifier.stop(),
            icon: Icon(Icons.stop, color: theme.stopColor),
          ),
        ],
      ),
    );
  }
}
