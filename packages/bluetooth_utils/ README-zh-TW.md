# 🌀 bluetooth_utils

一個模組化的藍牙工具包，使用 [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus) 完成主要功能實作。
目前僅供此專案內部使用，尚無計畫封裝成通用套件。

若你是第一次使用本套件，建議參考 [`example/`](example) 資料夾內的範例程式碼，其中包含各模組的基本使用方式。
  
---  

# 📁 專案架構說明

## 🧩 `presentation` - 藍牙 UI 呈現層

包含常見的藍牙互動介面：
- **`is_on`**：取得用戶藍牙是否開啟的狀態響應。
- **`others`**：其他輔助性藍牙介面功能模組。
- **`quick_connection`**：快速建立用戶可操作的藍牙掃描與連線介面。
- **`theme`**：藍牙相關的主題樣式管理。

---  

## 🔧 `services` - 藍牙邏輯服務層

封裝與藍牙邏輯操作相關的服務模組：
- **`application`**：快速建構專案常用藍牙應用服務的初始化流程。
- **`devices`**：負責處理 `BluetoothDevice` 的連線與操作邏輯。
- **`services`**：負責處理 `List<BluetoothService>` 的分析與管理流程。
