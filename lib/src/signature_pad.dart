import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qonvex_signature_pad/painter/signature_painter.dart';
import 'dart:async';
import 'package:qonvex_signature_pad/service/signature_service.dart';

class SignaturePad extends StatefulWidget {
  final bool renderWithBackground;
  final Color signatureColor;
  final double thickness;
  final StrokeCap strokeCap;

  SignaturePad(
      {Key? key,
      this.renderWithBackground = true,
      this.signatureColor = Colors.black,
      this.thickness = 3.0,
      this.strokeCap = StrokeCap.square})
      : super(key: key);

  @override
  SignaturePadState createState() => SignaturePadState();
}

class SignaturePadState extends State<SignaturePad> {
  /// Signature points offset container
  /// this will be passed to our painter
  List<Offset?> _points = [];

  /// key to control our state
  GlobalKey _globalKey = new GlobalKey();

  /// key to get our repaint boundary
  /// will be used to get the widget's data and convert it to bytes or base64
  GlobalKey _repaintKey = new GlobalKey();

  /// Contains our signature services
  final SignatureService _service = SignatureService.instance;

  /// points or signature eraser or can reset our signature
  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }

  /// getter for our base64 converted widget.
  Future<String?> get toBase64 async => await _service.toBase64(_repaintKey);

  /// getter for our byte converted widget.
  Future<Uint8List?> get toBytes async => await _service.bytes(_repaintKey);

  @override
  void dispose() {
    clearPoints();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      decoration: BoxDecoration(
          color:
              widget.renderWithBackground ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey.shade200, width: 1)),
      child: RepaintBoundary(
        key: _repaintKey,
        child: GestureDetector(
          onPanUpdate: (det) {
            setState(() {
              var renderBox = context.findRenderObject() as RenderBox;
              var localPosition = renderBox.globalToLocal(det.globalPosition);
              _points.add(localPosition);
            });
          },
          onPanDown: (det) {
            setState(() {
              _points.add(null);
            });
          },
          child: CustomPaint(
            painter: SignaturePainter(
                points: _points,
                thickness: widget.thickness,
                strokeCap: widget.strokeCap,
                signatureColor: widget.signatureColor),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
