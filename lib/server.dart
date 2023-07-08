import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart' as shelf;

class ImageServer {
  Future<shelf.Response> handleRequest(shelf.Request request) async {
    final imageBytes =
    await _getImageBytes(); // Retrieve image bytes from your source

    if (imageBytes != null) {
      return shelf.Response.ok(imageBytes,
          headers: {'content-type': 'image/png'});
    } else {
      return shelf.Response.notFound('Image not found');
    }
  }

  Future<Uint8List> _getImageBytes() async {
    try {
      final ByteData byteData = await rootBundle.load('assets/logo/splash.png');
      return byteData.buffer.asUint8List();
    } catch (e) {
      print('Error reading image file: $e');
      return Uint8List(0);
    }
  }
}