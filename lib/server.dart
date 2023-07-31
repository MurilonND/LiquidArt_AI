import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart' as shelf;

class ImageServer {
  Future<shelf.Response> handleRequest(shelf.Request request) async {
    final imageBytes = await _getImageBytes('assets/logo/cat.png');
    if (imageBytes != null) {
      final base64Image = base64Encode(imageBytes);
      final htmlResponse = '''
        <!DOCTYPE html>
        <html>
          <head>
            <style>
              body { margin: 0; padding: 0; height: 100vh; display: flex; justify-content: center; align-items: center; }
              .image-container { width: 100%; background-image: url('data:image/png;base64, $base64Image'); background-size: 300% 100%; }
              .image-container.image3 { background-position: 0 0; }
              .image-container.image1 { background-position: 33.33% 0; }
              .image-container.image2 { background-position: 66.66% 0; }
            </style>
          </head>
          <body>
            <div class="image-container ${_getImageClass(request.url.path)}"></div>
          </body>
        </html>
      ''';

      return shelf.Response.ok(htmlResponse,
          headers: {'content-type': 'text/html'});
    } else {
      return shelf.Response.notFound('Image not found');
    }
  }

  String _getImageClass(String path) {
    switch (path) {
      case '1':
        return 'image1';
      case '2':
        return 'image2';
      case '3':
        return 'image3';
      default:
        return '';
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
