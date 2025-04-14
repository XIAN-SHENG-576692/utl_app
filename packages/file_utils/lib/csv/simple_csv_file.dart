import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../constants.dart' as global;

/// A lightweight CSV file handler for reading and writing CSV content.
class SimpleCsvFile {
  /// Constructor to initialize the file with optional delimiters.
  SimpleCsvFile({
    required String path,
    this.delimiterColumn = ",",
    this.delimiterRow = "\n",
  }) : file = File(path);

  /// The underlying File object for I/O operations.
  final File file;

  /// Delimiter used to separate columns (default: comma).
  final String delimiterColumn;

  /// Delimiter used to separate rows (default: newline).
  final String delimiterRow;

  /// Clears the file content and writes optional BOM.
  ///
  /// [bom]: If true, writes the BOM bytes defined in global constants.
  /// [flush]: If true, ensures the write is flushed to disk immediately.
  Future clear({
    bool bom = false,
    bool flush = false,
  }) {
    return file.writeAsBytes(
      (bom) ? global.bom : List.empty(),
      mode: FileMode.write,
      flush: flush,
    );
  }

  /// Appends raw byte content to the file.
  ///
  /// [bytes]: The byte data to be written.
  /// [flush]: If true, flushes the buffer after writing.
  Future writeAsBytes({
    required Uint8List bytes,
    bool flush = false,
  }) {
    return file.writeAsBytes(
      bytes,
      mode: FileMode.append,
      flush: flush,
    );
  }

  /// Appends a row of CSV data as a string.
  ///
  /// [data]: A list of string values to be joined into one row.
  /// [encoding]: The character encoding (default: UTF-8).
  /// [flush]: If true, flushes the buffer after writing.
  Future<void> writeAsString({
    required Iterable<String> data,
    Encoding encoding = utf8,
    bool flush = false,
  }) {
    final contents = data.isEmpty
      ? delimiterRow
      : data.join(delimiterColumn) + delimiterRow;

    return file.writeAsString(
      contents,
      mode: FileMode.append,
      encoding: encoding,
      flush: flush,
    );
  }

  /// Reads the file and returns the content as a list of rows,
  /// where each row is a list of column values.
  ///
  /// [encoding]: The character encoding (default: UTF-8).
  Future<Iterable<Iterable<String>>> read({
    Encoding encoding = utf8,
  }) async {
    return file
      .readAsString(encoding: encoding)
      .then((value) => value
      .split(delimiterRow)
      .map((e) => e.split(delimiterColumn))
    );
  }
}
