import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qonvex_signature_pad/qonvex_signature_pad.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qonvex Signature Pad Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Qonvex Signature Pad Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getBase64() async {
    String? _base64 = await _globalKey.currentState!.toBase64;
    print("BASE64 DATA : $_base64");
  }

  void getBytes() async {
    Uint8List? bytes = await _globalKey.currentState!.toBytes;
    print("BYTES : $bytes");
  }

  void clearPoints() async {
    _globalKey.currentState!.clearPoints();
  }

  GlobalKey<SignaturePadState> _globalKey = new GlobalKey<SignaturePadState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SignaturePad(
        key: _globalKey,
      ),
    );
  }
}
