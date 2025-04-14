# path_provider_utils

A lightweight Dart utility for handling platform-specific file path access and asset extraction. Designed to simplify the process of accessing download directories and managing temporary asset files in both **Android** and **iOS** environments.

* * *

# ✨ Features
----------

*   🔍 **Cross-platform download directory detection**

    *   Uses `getApplicationDocumentsDirectory()` on iOS

    *   Uses global `/Download` or fallback to external storage on Android

*   📦 **Asset extraction**

    *   Converts bundled assets into temporary files

    *   Automatically renames paths (e.g. `assets/image.png` → `assets-image.png`) for safe file handling

    *   Avoids overwriting by checking file existence


* * *

# 📦 Installation
---------------

Make sure to include the following packages in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  path_provider: ^2.0.0
```

Also ensure your assets are registered if you use `getSystemAssetPath()`:

```yaml
flutter:
  assets:
    - assets/sample.txt
```

* * *

# 🚀 Usage
--------

### 1\. Get System Download Directory

```dart
Directory? downloadDir = await getSystemDownloadDirectory();
if (downloadDir != null) {
  print("Download directory path: ${downloadDir.path}");
}
```

> 📌 On Android, this will try to access `/storage/emulated/0/Download`. If it fails, it will use `getExternalStorageDirectory()`.

* * *

### 2\. Copy Asset to Temporary Directory

```dart
final tempDir = await getTemporaryDirectory();
final assetPath = 'assets/sample.txt';

String localAssetPath = await getSystemAssetPath(
  temporaryDirectory: tempDir,
  assetPath: assetPath,
);

print("Local asset path: $localAssetPath");
```

> 📦 Asset will only be written once. Future calls reuse the same file.

* * *

# ⚠️ Notes
--------

*   Android permissions may be required for file system access outside the app sandbox. Consider adding:


```xml
<!-- AndroidManifest.xml -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

*   iOS requires no additional permissions for `getApplicationDocumentsDirectory()`.


* * *

# 📁 File Overview
----------------

| Function | Description |
| --- | --- |
| `getSystemDownloadDirectory()` | Returns a platform-appropriate download path |
| `getSystemAssetPath()` | Extracts and returns the path of a bundled asset as a temporary file |

* * *

🛠 License
----------

This utility is free to use and modify under the MIT License.

* * *
