import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';


class ImageServer {
  Future<shelf.Response> handleRequest(shelf.Request request) async {
    if (request.url.path == '/1') {
      return _getImageResponse('assets/logo/cat.png');
    } else if (request.url.path == '/2') {
      return _getImageResponse('assets/logo/cat.png');
    } else if (request.url.path == '/3') {
      return _getImageResponse('assets/logo/cat.png');
    } else {
      return shelf.Response.notFound('Route not found ${request.url.path}');
    }
  }

  Future<shelf.Response> _getImageResponse(String imagePath) async {
    final imageBytes = await _getImageBytes(imagePath);
    if (imageBytes != null) {
      return shelf.Response.ok(imageBytes, headers: {'content-type': 'image/png'});
    } else {
      return shelf.Response.notFound('Image not found');
    }
  }

  Future<Uint8List?> _getImageBytes(String imagePath) async {
    try {
      final ByteData byteData = await rootBundle.load(imagePath);
      return byteData.buffer.asUint8List();
    } catch (e) {
      print('Error reading image file: $e');
      return null;
    }
  }
}