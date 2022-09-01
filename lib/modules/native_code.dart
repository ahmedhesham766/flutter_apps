import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  const NativeCodeScreen({Key? key}) : super(key: key);

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {

  static const platform = MethodChannel('samples.flutter.dev/battery');

  String batterylevel = 'no battery reading';

  void getBatteryLevel()
  {
    platform.invokeMethod('getBatteryLevel')
        .then((value) {
          setState(() {
            batterylevel = 'Battery level at $value % .';
          });
    }).catchError((error){
      setState((){
        batterylevel = "Failed to get battery level: '${error.message}'.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(batterylevel),
          ],
        ),
      ),
    );
  }
}
