import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class SignatureService {
  SignatureService._private();
  static final SignatureService _instance = SignatureService._private();
  static SignatureService get instance => _instance;

  Future<Uint8List?> bytes(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> toBase64(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      return bs64;
    } catch (e) {
      print(e);
      return null;
    }
  }

}