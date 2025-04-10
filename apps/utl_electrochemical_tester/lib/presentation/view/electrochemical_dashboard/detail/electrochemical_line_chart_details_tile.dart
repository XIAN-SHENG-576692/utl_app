import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

class _Item {
  final String label;
  final String data;
  const _Item({
    required this.label,
    required this.data,
  });
}

class ElectrochemicalLineChartDetailsTile extends StatelessWidget {
  final ElectrochemicalLineChartDetail detail;
  final ElectrochemicalLineChartMode mode;
  const ElectrochemicalLineChartDetailsTile({
    super.key,
    required this.detail,
    required this.mode,
  });
  Widget _buildText({
    required List<_Item> items,
    required Color color,
  }) {
    final text = items.map((item) => "${item.label}: ${item.data}").join(", ");
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            softWrap: true,
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final yItem = _Item(
      label: appLocalizations.current,
      data: detail
        .data
        .map((e) => e.current.toString())
        .join(", "),
    );
    return Column(
      children: [
        _buildText(
          items: [
            _Item(
              label: appLocalizations.name,
              data: detail.dataName,
            ),
            _Item(
              label: appLocalizations.type,
              data: detail.type.name,
            ),
          ],
          color: detail.color,
        ),
        _buildText(
          items: [
            _Item(
              label: appLocalizations.temperature,
              data: detail.temperature.toString(),
            ),
          ],
          color: detail.color,
        ),
        _buildText(
          items: [
            _Item(
              label: appLocalizations.time,
              data: detail.createdTime.toString(),
            ),
          ],
          color: detail.color,
        ),
        _buildText(
          items: [
            yItem,
          ],
          color: detail.color,
        ),
        Divider(),
      ],
    );
  }
}
