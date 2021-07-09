import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class QonvexSignatureService {
  QonvexSignatureService._private();

  static final QonvexSignatureService _instance =
      QonvexSignatureService._private();

  static QonvexSignatureService get instance => _instance;

  /// Convert signature to byte
  Future<Uint8List?> bytes(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Convert signature to base64
  Future<String?> toBase64(GlobalKey globalKey) async {
    try {
      var pngBytes = await bytes(globalKey);
      var bs64 = base64Encode(pngBytes!);
      return bs64;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
