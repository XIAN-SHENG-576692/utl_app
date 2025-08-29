import 'dart:ui';

import 'package:common_utils/dataset_color_generator.dart';

class ColorsMapper {
  ColorsMapper._();
  static Color mapElectrochemicalEntitiesToColor({
    required int index,
    required int length,
  }) {
    return DatasetColorGenerator.rainbowGroup(
      alpha: 1.0,
      index: 1,
      length: 1,
      groupIndex: index,
      groupLength: length,
    );
  }
}
