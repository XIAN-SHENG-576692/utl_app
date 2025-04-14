/// Extension: Adds a custom formatting method to the DateTime class
extension DateTimeStringFormat on DateTime {

  /// Method: Converts the DateTime object into a string formatted for filenames.
  ///
  /// Format: YYYY-MM-DD_HH-MM-SS_mmmuuu
  ///   - YYYY: 4-digit year
  ///   - MM:   2-digit month
  ///   - DD:   2-digit day
  ///   - HH:   2-digit hour (24-hour format)
  ///   - MM:   2-digit minute
  ///   - SS:   2-digit second
  ///   - mmm:  3-digit millisecond
  ///   - uuu:  3-digit microsecond
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final now = DateTime(2025, 4, 14, 9, 5, 7, 3, 45);
  /// final filename = now.toFileFormat();
  /// print(filename);
  /// // Output: 2025-04-14_09-05-07_003045
  /// ```
  ///
  /// This format is safe for filenames across all operating systems
  /// because it avoids slashes (/) and colons (:), which are invalid in file names.

  String toFileNameFormat() {
    return "${year.toString().padLeft(2, '0')}"
        "-${month.toString().padLeft(2, '0')}"
        "-${day.toString().padLeft(2, '0')}"
        "_${hour.toString().padLeft(2, '0')}"
        "-${minute.toString().padLeft(2, '0')}"
        "-${second.toString().padLeft(2, '0')}"
        "_${millisecond.toString().padLeft(3, '0')}"
        "${microsecond.toString().padLeft(3, '0')}";
  }
}
