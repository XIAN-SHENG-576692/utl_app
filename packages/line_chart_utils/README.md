# 📈 Line Chart State Management with Syncfusion Flutter Charts

A modular Flutter state management system built for dynamic and interactive line charts using [Syncfusion Flutter Charts](https://pub.dev/packages/syncfusion_flutter_charts). This setup supports reactive updates, trackball-based interaction, and customizable series management using `ChangeNotifier`.

---

## 🔧 Features

- ✅ Centralized state management using `ChangeNotifier`
- 📊 Dynamic X-axis data tracking (`x`)
- 👆 Touch interaction detection (`isTouched`)
- 🔁 Reactive `LineSeries` list updates
- 🎯 Trackball-based data object extraction

---

## 📁 File Structure

```bash
lib/
├── line_chart_change_notifier.dart                  # Base notifier for X-axis and touch state
└── sf_cartesian_chart
    ├── line_series_list_chart_change_notifier.dart  # Extended notifier with LineSeries list management
    └── sf_cartesian_chart_handler.dart              # Utility for extracting data from trackball
```

* * *

🚀 Getting Started
------------------

### 1\. Add dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  syncfusion_flutter_charts: ^XX.X.X # Replace with latest version
```

### 2\. Import the modules

```dart
import 'line_chart_change_notifier.dart';
import 'line_series_list_chart_change_notifier.dart';
import 'sf_cartesian_chart_handler.dart';
```

* * *

🧩 Usage Example
----------------

### Initialize the notifier

```dart
final chartNotifier = LineSeriesListChartChangeNotifier<MyData, DateTime>(x: null);
```

### Update series list dynamically

```dart
chartNotifier.lineSeriesList = [
  LineSeries<MyData, DateTime>(
    dataSource: myDataList,
    xValueMapper: (data, _) => data.time,
    yValueMapper: (data, _) => data.value,
  )
];
```

### Handle trackball interaction

```dart
SfCartesianChart(
  onTrackballPositionChanging: (TrackballArgs args) {
    final source = SfCartesianChartHandler.findSourceOnTrackballPositionChanging<MyData, DateTime>(
      series: chartNotifier.lineSeriesList,
      trackballArgs: args,
    );
    if (source != null) {
      chartNotifier.x = source.time;
    }
  },
)
```

* * *

# 🧪 Testing & Debugging
----------------------

*   `notifyListeners()` is overridden with `@visibleForTesting` and `@pragma('vm:notify-debugger-on-exception')` for better testability and error tracking.


* * *

# 🧠 Why Use This?
----------------

*   Encourages separation of concerns between chart logic and UI

*   Scales easily for multiple charts or series

*   Improves user interaction tracking with `trackballArgs`

*   Perfect for dashboards, financial data, or scientific plotting


* * *

# 📜 License
----------

MIT License. See `LICENSE` file for details.

* * *

# ✨ Credits
---------

Created using Syncfusion Flutter Charts and Flutter’s state management tools.
