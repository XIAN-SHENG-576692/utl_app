import 'package:flutter/material.dart';
import 'package:hex_keyboard/hex_keyboard.dart';
import 'package:hex_keyboard/hex_keyboard_controller.dart';
import 'package:hex_keyboard/hex_keyboard_input_field.dart';
import 'package:hex_keyboard/hex_keyboard_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _manager = HexKeyboardManager();
  late final HexKeyboardController _controller0;
  late final HexKeyboardController _controller1;

  void _setState() {
    return setState(() {});
  }

  @override
  void initState() {
    _manager.addListener(_setState);
    _controller0 = HexKeyboardController();
    _controller1 = HexKeyboardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HexKeyboardInputField(
            controller: _controller0,
            manager: _manager,
          ),
          HexKeyboardInputField(
            controller: _controller1,
            manager: _manager,
          ),
          (_manager.active == null || !_manager.hasFocus)
            ? Row()
            : HexKeyboard(
              manager: _manager,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller0.dispose();
    _controller1.dispose();
    _manager.dispose();
    super.dispose();
  }

}