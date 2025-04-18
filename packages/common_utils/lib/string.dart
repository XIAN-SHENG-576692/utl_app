import 'dart:typed_data';

extension ToUint8List on String {
  /// Converts a hex string to a Uint8List.
  /// Throws a FormatException if the string is not valid hex.
  Uint8List hexToUint8List() {
    if (length % 2 != 0) {
      throw const FormatException("Invalid hex string: length must be even.");
    }
    return Uint8List.fromList(List.generate(length ~/ 2, (int index) {
      final hexPair = substring(index * 2, index * 2 + 2);
      final byte = int.tryParse(hexPair, radix: 16);
      if(byte == null) throw const FormatException("Invalid hex string: contains non-hexadecimal characters.");
      return byte;
    }));
  }
}

extension CharacterConvertor on String {
  decodeHtml() {
    return replaceAll('&amp;', '/')
      .replaceAll("&quot;", "\"")
      .replaceAll("&ldquo;", "“")
      .replaceAll("&rdquo;", "”")
      .replaceAll("<br>", "\n")
      .replaceAll("&gt;", ">")
      .replaceAll("&lt;", "<");
  }
}
