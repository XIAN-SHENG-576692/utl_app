import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// A stateless widget that displays a UI when Bluetooth is turned off.
///
/// This view is typically used to prompt the user to enable Bluetooth,
/// offering a customizable message, background color, text color, and button label.
class BluetoothOffView extends StatelessWidget {
  /// Background color of the screen. Defaults to light blue.
  final Color? backGroundColor;

  /// Color of the text message. Defaults to white.
  final Color? textColor;

  /// Message shown to the user when Bluetooth is off.
  final String message;

  /// Label of the button that prompts the user to turn Bluetooth on.
  final String buttonText;

  /// Constructor with optional customization for UI appearance and text content.
  const BluetoothOffView({
    super.key,
    this.backGroundColor = Colors.lightBlue,
    this.textColor = Colors.white,
    this.message = 'Bluetooth Adapter is not available.',
    this.buttonText = 'TURN ON',
  });

  @override
  Widget build(BuildContext context) {
    // Get theme data from context to apply consistent text styles.
    final themeData = Theme.of(context);

    // Icon displayed when Bluetooth is off.
    const Widget icon = Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );

    // Text message displayed under the icon.
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

    // Button that, when pressed, triggers Bluetooth to turn on using FlutterBluePlus.
    final Widget turnOnButton = Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: FlutterBluePlus.turnOn,
        child: Text(buttonText),
      ),
    );

    // The main UI layout of the screen using a centered column.
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
