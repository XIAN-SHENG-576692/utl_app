# 🌀 bluetooth_utils

一个模块化的蓝牙工具包，基于 [flutter_blue_plus](https://pub.dev/packages/flutter_blue_plus) 实现主要功能。  
目前仅供本项目内部使用，暂无封装为通用库的计划。

如果你是第一次使用本工具包，建议参考 [`example/`](example) 目录中的示例代码，其中包含各模块的基本用法。

---

# 📁 项目结构说明

## 🧩 `presentation` – 蓝牙 UI 展示层

该层包含常见的蓝牙交互界面组件：
- **`is_on`**：获取用户蓝牙是否开启的状态响应。
- **`others`**：其他辅助性的蓝牙 UI 功能模块。
- **`quick_connection`**：快速构建用户可操作的蓝牙扫描与连接界面。
- **`theme`**：蓝牙相关的主题样式管理。

---

## 🔧 `services` – 蓝牙业务逻辑层

封装与蓝牙操作相关的服务模块：
- **`application`**：快速搭建项目中常用的蓝牙应用服务初始化流程。
- **`devices`**：负责处理 `BluetoothDevice` 的连接与操作逻辑。
- **`services`**：负责处理 `List<BluetoothService>` 的解析与管理流程。
