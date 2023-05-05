import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Level',
      home: BatteryLevelScreen(),
    );
  }
}

class BatteryLevelScreen extends StatefulWidget {
  @override
  _BatteryLevelScreenState createState() => _BatteryLevelScreenState();
}

class _BatteryLevelScreenState extends State<BatteryLevelScreen> {
  late int _batteryLevel;

  Future<void> _getBatteryLevel() async {
    final platform = MethodChannel('my_channel_name');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            SizedBox(height: 16),
            Text(
              _batteryLevel != null
                  ? 'Battery level: $_batteryLevel%'
                  : 'Press button to get battery level.',
            ),
          ],
        ),
      ),
    );
  }
}
