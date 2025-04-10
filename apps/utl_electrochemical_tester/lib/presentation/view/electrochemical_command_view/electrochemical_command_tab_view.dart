import 'package:flutter/material.dart';

import '../../../domain/value/electrochemical_parameters.dart';
import 'item/electrochemical_command_ad5940_view.dart';
import 'item/electrochemical_command_header_view.dart';
import 'item/type/electrochemical_command_type_view.dart';

class ElectrochemicalCommandTabView extends StatefulWidget {
  final ElectrochemicalType type;

  const ElectrochemicalCommandTabView({super.key, required this.type});

  @override
  _ElectrochemicalCommandTabViewState createState() => _ElectrochemicalCommandTabViewState();
}

class _ElectrochemicalCommandTabViewState extends State<ElectrochemicalCommandTabView> {
  final GlobalKey _headerKey = GlobalKey();
  double _headerHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateHeaderHeight();
    });
  }

  void _updateHeaderHeight() {
    final RenderBox? renderBox = _headerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      setState(() {
        _headerHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 滾動區域
          Padding(
            padding: EdgeInsets.only(top: _headerHeight),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      ElectrochemicalCommandAd5940View(),
                      Divider(),
                      ElectrochemicalCommandTypeView(type: widget.type),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 4,
              child: ElectrochemicalCommandHeaderView(
                key: _headerKey,
                type: widget.type,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
