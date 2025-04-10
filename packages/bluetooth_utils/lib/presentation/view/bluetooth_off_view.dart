import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothOffView extends StatelessWidget {
  final Color? backGroundColor;
  final Color? textColor;
  final String message;
  final String buttonText;
  const BluetoothOffView({
    super.key,
    this.backGroundColor = Colors.lightBlue,
    this.textColor = Colors.white,
    this.message = 'Bluetooth Adapter is not available.',
    this.buttonText = 'TURN ON',
  });
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    const Widget icon = Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );
    final Widget title = Builder(
      builder: (context) {
        return Text(
          message,
          style: themeData
              .primaryTextTheme
              .titleSmall
              ?.copyWith(
            color: textColor,
          ),
        );
      },
    );
    final Widget turnOnButton = Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: FlutterBluePlus.turnOn,
        child: Text(buttonText),
      ),
    );
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              title,
              turnOnButton,
            ],
          ),
        ),
      ),
    );
  }
}
