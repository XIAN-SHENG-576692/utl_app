class ElectrochemicalAlgorithm {
  Iterable<double> movingAverage({required Iterable<double> data}) sync* {
    final window = 3;
    final l = data.toList(), h = window ~/ 2;
    for(int i=0; i<l.length; i++) {
      final r = l.sublist((i - h).clamp(0, l.length - 1), (i + h + 1).clamp(0, l.length));
      yield r.reduce((a, b) => a + b) / r.length;
    }
  }
  Iterable<double> savitzkyGolay({required Iterable<double> data}) sync* {
    const c = <double>[-3/35, 12/35, 17/35, 12/35, -3/35];
    final n = data.length, h = c.length ~/ 2;

    for (var i = 0; i < n; i++) {
      yield List.generate(c.length, (j) {
        final k = i + j - h;
        return (k >= 0 && k < n) ? data.elementAt(k) * c.elementAt(j) : 0.0;
      }).reduce((a, b) => a + b);
    }
  }
  Iterable<double> baselineSubtraction({required Iterable<double> data}) sync* {
    yield 0.0;
  }
}
