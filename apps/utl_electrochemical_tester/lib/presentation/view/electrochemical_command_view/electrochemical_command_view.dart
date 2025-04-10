import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/value/electrochemical_parameters.dart';
import '../../change_notifier/electrochemical/command/electrochemical_command_change_notifier.dart';
import '../../widget/icons.dart';
import 'electrochemical_command_tab_view.dart';

class ElectrochemicalCommandView extends StatelessWidget {
  const ElectrochemicalCommandView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<ElectrochemicalCommandChangeNotifier>();
    final tabIconData = ElectrochemicalIcons.typeIconData;
    final electrochemicalCommandTabViews = ElectrochemicalType
      .values
      .map((type) => ElectrochemicalCommandTabView(
          type: type,
      ));
    final tabBar = TabBar(
      isScrollable: false,
      tabs: tabIconData.map((iconData) {
        return Tab(
          icon: Icon(iconData),
        );
      }).toList(),
      onTap: notifier.setCommandTabIndexBuffer,
    );
    final tabView = TabBarView(
      children: electrochemicalCommandTabViews.toList(),
    );
    final tabController = DefaultTabController(
      length: ElectrochemicalType.values.length,
      initialIndex: notifier.getCommandTabIndexBuffer(),
      child: Scaffold(
        appBar: tabBar,
        body: tabView,
      ),
    );
    return tabController;
  }
}
