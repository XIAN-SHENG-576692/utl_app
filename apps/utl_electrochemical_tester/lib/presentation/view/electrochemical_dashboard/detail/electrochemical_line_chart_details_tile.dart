import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/electrochemical_entity.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../change_notifier/electrochemical/line_chart/electrochemical_line_chart_change_notifier.dart';

class _Item {
  final String label;
  final String data;
  const _Item({
    required this.label,
    required this.data,
  });
}

class ElectrochemicalLineChartDetailsTileDto extends Equatable {
  final Color color;
  final ElectrochemicalHeader header;
  final List<double> xFetchedData;
  const ElectrochemicalLineChartDetailsTileDto({
    required this.color,
    required this.header,
    required this.xFetchedData,
  });
  @override
  List<Object?> get props => [
    header,
    xFetchedData,
  ];
}

class ElectrochemicalLineChartDetailsTile extends StatelessWidget {
  final ElectrochemicalLineChartDetailsTileDto dto;
  final ElectrochemicalLineChartMode mode;
  const ElectrochemicalLineChartDetailsTile({
    super.key,
    required this.dto,
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
    final color = dto.color;
    final header = dto.header;
    final xFetchedData = dto.xFetchedData;
    final yItem = _Item(
      label: appLocalizations.current,
      data: xFetchedData
        .map((e) => e.toString())
        .join(", "),
    );
    return Column(
      children: [
        _buildText(
          items: [
            _Item(
              label: appLocalizations.name,
              data: header.dataName,
            ),
            _Item(
              label: appLocalizations.type,
              data: header.type.name,
            ),
          ],
          color: color,
        ),
        _buildText(
          items: [
            _Item(
              label: appLocalizations.temperature,
              data: header.temperature.toString(),
            ),
          ],
          color: color,
        ),
        _buildText(
          items: [
            _Item(
              label: appLocalizations.time,
              data: header.createdTime.toString(),
            ),
          ],
          color: color,
        ),
        _buildText(
          items: [
            yItem,
          ],
          color: color,
        ),
        Divider(),
      ],
    );
  }
}
