import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Get the system's download directory.
///
/// On iOS, it returns the application's document directory.
/// On Android, it tries to return the global `/Download` directory.
/// If it doesn't exist, it falls back to the external storage directory.
Future<Directory?> getSystemDownloadDirectory() async {
  try {
    if (Platform.isIOS) {
      // For iOS, use the app's document directory
      return getApplicationDocumentsDirectory();
    } else {
      // For Android, attempt to use the global Download directory
      Directory download = Directory('/storage/emulated/0/Download');
      // If the directory exists, return it
      // Otherwise, fallback to a general external storage directory
      // ignore: avoid_slow_async_io
      if (await download.exists()) {
        return download;
      } else {
        return getExternalStorageDirectory();
      }
    }
  } catch (err, stack) {
    // Print an error if directory retrieval fails
    debugPrint("Cannot get _application_documents_directory");
  }
  return null;
}

/// Copy a bundled asset to a temporary file and return its path.
///
/// [temporaryDirectory]: the directory to store the temporary file.
/// [assetPath]: the path of the asset in the bundle (e.g., 'assets/data.txt').
///
/// If the file already exists, it reuses it; otherwise, it copies it from the bundle.
/// It replaces all slashes in the asset path with hyphens to avoid nested paths.
Future<String> getSystemAssetPath({
  required Directory temporaryDirectory,
  required String assetPath,
}) async {
  final find = '/';
  final replaceWith = '-';

  // Convert asset path to a safe file name by replacing slashes with hyphens
  final temporaryAssetPath = assetPath.replaceAll(find, replaceWith);
  final tempFile = File("$temporaryDirectory/$temporaryAssetPath");

  // If the file doesn't exist, load the asset and write it to the file system
  if(!(await tempFile.exists())) {
    final byteData = await rootBundle.load(assetPath);
    await tempFile.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
  }

  // Return the absolute path to the temp file
  return tempFile.absolute.path;
}
