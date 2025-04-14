import 'package:syncfusion_flutter_charts/charts.dart';

/// A utility class to handle interactions with [SfCartesianChart],
/// specifically focusing on trackball interactions.
///
/// This class provides static helper methods and is not meant to be instantiated.
class SfCartesianChartHandler {
  // Private constructor to prevent instantiation of this utility class.
  SfCartesianChartHandler._();

  /// Finds the corresponding data source item based on the trackball's
  /// current position when it's moving across the chart.
  ///
  /// This method is designed to extract the specific data object that the
  /// trackball is currently highlighting. It safely checks for index boundaries
  /// and returns `null` if the indices are not valid.
  ///
  /// Type Parameters:
  /// - [Source]: The type of the data objects in the series.
  /// - [X]: The type of the data used on the X-axis.
  ///
  /// Parameters:
  /// - [series]: A list of [LineSeries] representing the data series in the chart.
  /// - [trackballArgs]: An instance of [TrackballArgs] containing information
  ///   about the currently highlighted chart point.
  ///
  /// Returns:
  /// - The data item of type [Source] corresponding to the current trackball
  ///   position, or `null` if not found or out of bounds.
  static Source? findSourceOnTrackballPositionChanging<Source, X>({
    required List<LineSeries<Source, X>> series,
    required TrackballArgs trackballArgs,
  }) {
    // Extract the series and data point indices from the trackball arguments
    int? seriesIndex = trackballArgs.chartPointInfo.seriesIndex;
    int? dataPointIndex = trackballArgs.chartPointInfo.dataPointIndex;

    // Return null if any index is missing or invalid
    if (seriesIndex == null || dataPointIndex == null) return null;

    // Safely retrieve the data source item if the indices are valid
    return series
        .elementAtOrNull(seriesIndex)
        ?.dataSource
        ?.elementAtOrNull(dataPointIndex);
  }
}
