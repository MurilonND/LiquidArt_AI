import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'src/features/connection/infrastructure/galaxy_cubit.dart';

HttpServer? server; // Declare a global variable to hold the server instance

void startImageServer(String imagePath, int lgScreens) async {
  final imageServer = ImageServer();
  final networkInfo = NetworkInfo();
  String? wifiIPv4 = '';

  try {
    wifiIPv4 = await networkInfo.getWifiIP();
  } on PlatformException catch (e) {
    print('Failed to get Wifi IPv4 error: $e');
  }

  final address = wifiIPv4 ?? ''; // Bind to any IPv4 address on the machine
  const port = 3000; // Port number to listen on

  server = await shelf_io.serve((shelf.Request request) => imageServer.handleRequest(request, imagePath, lgScreens),
      address, port);

  print('Image server running on ${server?.address.host}:${server?.port}');
}

void rerunImageServer(String imagePath, int lgScreens) async {
  if (server != null) {
    await server!.close();
    server = null; // Reset the server instance
    startImageServer(imagePath, lgScreens);
  } else {
    startImageServer(imagePath, lgScreens);
  }
}

class ImageServer {
  Future<shelf.Response> handleRequest(shelf.Request request, String imagePath, int lgScreens) async {
    final logoBytes = await _getImageBytes('assets/logo/splash.png');
    final imageBytes = await _getImageBytes(imagePath);
    if (imageBytes != null && logoBytes != null) {
      final base64Logo = base64Encode(logoBytes);
      final base64Image = base64Encode(imageBytes);
      final htmlResponse = '''
        <!DOCTYPE html>
        <html>
          <head>
            <style>
              body { margin: 0; padding: 0; height: 100vh; display: flex; justify-content: start; align-items: start; }
              .logo-container3 { width: 50%; height: 50%; background-image: url('data:image/png;base64, $base64Logo'); background-size: 100% 100%; position: absolute; z-index: 1; }
              .logo-container5 { width: 100%; height: 100%; background-image: url('data:image/png;base64, $base64Logo'); background-size: 100% 100%; position: absolute; z-index: 1; }
              .image-container { width: 100%; height: 100%; background-image: url('data:image/png;base64, $base64Image'); background-size: 300% 100%; }
              .image-container.image3 { background-position: 0 0; }
              .image-container.image1 { background-position: 50% 0; }
              .image-container.image2 { background-position: 100% 0; }
              .image-container.5 { background-position: 0 0; }
              .image-container.3 { background-position: 25% 0; }
              .image-container.1 { background-position: 50% 0; }
              .image-container.2 { background-position: 75% 0; }
              .image-container.4 { background-position: 100% 0; }
            </style>
          </head>
          <body>
            <div class="${_getLogoClass(request.url.path)}"></div>
            <div class="image-container ${_getImageClass(request.url.path, lgScreens)}"></div>
          </body>
        </html>
      ''';

      return shelf.Response.ok(htmlResponse,
          headers: {'content-type': 'text/html'});
    } else {
      return shelf.Response.notFound('Image not found');
    }
  }

  String _getLogoClass(String path){
    if(path == '3' || path == '5'){
      switch (path) {
        case '3':
          return 'logo-container3';
        case '5':
          return 'logo-container5';
        default:
          return '';
      }
    }
    return '';
  }

  String _getImageClass(String path, int lgScreens) {
    if(lgScreens == 5){
      switch (path) {
        case '1':
          return '1';
        case '2':
          return '2';
        case '3':
          return '3';
        case '4':
          return '4';
        case '5':
          return '5';
        default:
          return '';
      }
    }else{
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
