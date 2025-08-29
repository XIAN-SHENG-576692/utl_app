import 'package:bluetooth_utils/presentation/is_on/bluetooth_is_on_view.dart';
import 'package:bluetooth_utils/presentation/quick_connection/bluetooth_quick_connection.dart';
import 'package:flutter/material.dart';
import 'package:utl_seat_cushion/presentation/view/seat_cushion/widgets/3d_mesh/seat_cushion_3d_mesh_widget.dart';

import '../view/bluetooth/bluetooth_hex_keyboard_view.dart';
import '../view/seat_cushion/seat_cushion_dashboard_view.dart';
import '../widget/widget_resources.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final bluetoothScannerView = BluetoothQuickConnectionScannerView();
    final seatCushionDashboardView = BluetoothHexKeyboardView(
      child: SeatCushionDashboardView(),
    );
    final seatCushion3dMeshView = SeatCushion3dMeshWidget();
    final tabViewMap = {
      WidgetResources.bluetoothScannerIcon:
      bluetoothScannerView,
      WidgetResources.seatCushionIcon:
      seatCushionDashboardView,
      WidgetResources.seatCushion3dMeshIcon:
      seatCushion3dMeshView,
    };
    return BluetoothIsOnView(
      isOnView: DefaultTabController(
        length: tabViewMap.length,
        child: SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: false,
              appBar: TabBar(
                isScrollable: false,
                tabs: tabViewMap.keys.map((title) {
                  return Tab(
                    icon: title,
                  );
                }).toList(),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: tabViewMap.values.toList(),
              ),
          ),
        ),
      ),
    );
  }
}
