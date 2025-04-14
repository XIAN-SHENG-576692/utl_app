import 'dart:math';
import 'package:bluetooth_utils/presentation/is_on/bluetooth_is_on_view.dart';
import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';

import '../view/electrochemical_command_view/electrochemical_command_view.dart';
import '../view/electrochemical_dashboard/electrochemical_line_chart_dashboard.dart';
import '../view/electrochemical_line_chart/electrochemical_line_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final electrochemicalLineChart = ElectrochemicalLineChart();
    final Map<Icon, Widget> tabViewMap = {
      const Icon(Icons.bluetooth_searching_rounded): BluetoothQuickConnectionScannerView(),
      const Icon(Icons.list_alt): ElectrochemicalCommandView(),
      const Icon(Icons.smart_button_sharp): ElectrochemicalLineChartDashboard(),
    };

    return DefaultTabController(
      length: tabViewMap.length,
      child: BluetoothIsOnView(
        isOnView: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final mediaQuery = MediaQuery.of(context);
            final isPortrait = mediaQuery.orientation == Orientation.portrait;

            final tabBar = TabBar(
              isScrollable: false,
              tabs: tabViewMap.keys.map((icon) => Tab(icon: icon)).toList(),
            );

            final tabView = TabBarView(
              children: tabViewMap.values.toList(),
            );

            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: isPortrait
                  ? _buildPortraitLayout(electrochemicalLineChart, tabBar, tabView, constraints, mediaQuery)
                  : _buildLandscapeLayout(electrochemicalLineChart, tabBar, tabView, constraints, mediaQuery),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(
    Widget electrochemicalLineChart,
    TabBar tabBar,
    TabBarView tabView,
    BoxConstraints constraints,
    MediaQueryData mediaQuery,
  ) {
    final controllerHeight = min(
      constraints.maxHeight / 2,
      constraints.maxHeight - mediaQuery.viewInsets.vertical,
    );

    return Column(
      children: <Widget>[
        Expanded(
          child: electrochemicalLineChart,
        ),
        const Divider(
          thickness: 2,
          height: 2,
        ),
        Expanded(
          child: SizedBox(
            height: controllerHeight,
            child: _buildTabScaffold(tabBar, tabView),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(
    Widget electrochemicalLineChart,
    TabBar tabBar,
    TabBarView tabView,
    BoxConstraints constraints,
    MediaQueryData mediaQuery,
  ) {
    final controllerWidth = min(
      constraints.maxWidth / 2,
      constraints.maxWidth - mediaQuery.viewInsets.horizontal,
    );

    return Row(
      children: <Widget>[
        Expanded(child: electrochemicalLineChart),
        const VerticalDivider(
          thickness: 2,
          width: 2,
        ),
        Expanded(
          child: SizedBox(
            width: controllerWidth,
            child: _buildTabScaffold(tabBar, tabView),
          ),
        ),
      ],
    );
  }

  Widget _buildTabScaffold(TabBar tabBar, TabBarView tabView) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: tabBar,
      ),
      body: tabView,
    );
  }
}
