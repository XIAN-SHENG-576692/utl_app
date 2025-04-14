import 'dart:typed_data';

/// Refers to https://stackoverflow.com/questions/69090275/uint8list-vs-listint-what-is-the-difference
/// Converts a `List<int>` to a [Uint8List].
///
/// Attempts to cast to a [Uint8List] first to avoid creating an unnecessary
/// copy.
extension AsUint8List on List<int> {
  Uint8List asUint8List() {
    final self = this; // Local variable to allow automatic type promotion.
    return (self is Uint8List) ? self : Uint8List.fromList(this);
  }
}

/// Define an extension on Uint8List to add a new method
extension Uint8ListString on Uint8List {

  /// Method: Converts each byte into a two-character hexadecimal string.
  /// Parameter:
  ///   - upperCase: If true (default), letters A–F are uppercase. If false, a–f.
  ///
  /// Returns: Iterable<String> — a list of hex strings representing each byte.
  ///
  /// Example usage:
  /// ```dart
  /// final bytes = Uint8List.fromList([0, 10, 255, 128]);
  ///
  /// // Convert to uppercase hex strings
  /// final upper = bytes.toByteStrings(); // upperCase = true by default
  /// print(upper.toList()); // Output: [00, 0A, FF, 80]
  ///
  /// // Convert to lowercase hex strings
  /// final lower = bytes.toByteStrings(upperCase: false);
  /// print(lower.toList()); // Output: [00, 0a, ff, 80]
  /// ```
  Iterable<String> toByteStrings({bool upperCase = true}) sync* {
    // Iterate over each byte in the Uint8List
    for (final byte in this) {
      // Convert the byte to a hexadecimal string (e.g., 10 → 'a')
      // Pad it to two characters (e.g., 'a' → '0a')
      final hex = byte.toRadixString(16).padLeft(2, '0');

      // Yield either uppercase or lowercase based on the flag
      yield upperCase ? hex.toUpperCase() : hex;
    }
  }
}
