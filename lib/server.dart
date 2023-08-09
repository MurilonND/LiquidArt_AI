import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

HttpServer? server; // Declare a global variable to hold the server instance

void startImageServer(String? imagePath, int lgScreens, Uint8List? imageFileBytes) async {
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

  server = await shelf_io.serve((shelf.Request request) => imageServer.handleRequest(request, imagePath, lgScreens, imageFileBytes),
      address, port);

  print('Image server running on ${server?.address.host}:${server?.port}');
}

void rerunImageServer(String? imagePath, int lgScreens, Uint8List? imageFileBytes) async {
  if (server != null) {
    await server!.close();
    server = null; // Reset the server instance
    startImageServer(imagePath, lgScreens, imageFileBytes);
  } else {
    startImageServer(imagePath, lgScreens, imageFileBytes);
  }
}

class ImageServer {
  Future<shelf.Response> handleRequest(shelf.Request request, String? imagePath, int lgScreens, Uint8List? imageFileBytes) async {
    final logoBytes = await _getImageBytes('assets/logo/splash.png');
    Uint8List? imageBytes;
    if(imagePath != null){
      imageBytes = await _getImageBytes(imagePath);
    }else{
      imageBytes = imageFileBytes!;
    }
    if (imageBytes != null && logoBytes != null) {
      final base64Logo = base64Encode(logoBytes);
      final base64Image = base64Encode(imageBytes);
      final htmlResponse = '''
        <!DOCTYPE html>
        <html>
          <head>
            <style>
              body { margin: 0; padding: 0; height: 100vh; display: flex; justify-content: start; align-items: start; }
              .logo-container { width: 50vw; height: 50vw; background-image: url('data:image/png;base64, $base64Logo'); background-size: 100% 100%; position: absolute; z-index: 1; }
              .image-container { width: 100%; height: 100%; background-image: url('data:image/png;base64, $base64Image'); background-size: ${_getImageWight(lgScreens)} 100%; }
              .image-container.image33 { background-position: 0 0; }
              .image-container.image31 { background-position: 50% 0; }
              .image-container.image32 { background-position: 100% 0; }
              .image-container.image55 { background-position: 0 0; }
              .image-container.image53 { background-position: 25% 0; }
              .image-container.image51 { background-position: 50% 0; }
              .image-container.image52 { background-position: 75% 0; }
              .image-container.image54 { background-position: 100% 0; }
            </style>
          </head>
          <body>
            <div class="${_getLogoClass(request.url.path, lgScreens)}"></div>
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

  String _getLogoClass(String path, int lgScreens){
    if(path == lgScreens.toString()){
          return 'logo-container';
      }
    return '';
  }

  String _getImageWight(int lgScreens){
    if(lgScreens == 5){
      return '500%';
    }else{
      return '300%';
    }
  }

  String _getImageClass(String path, int lgScreens) {
    if(lgScreens == 5){
      switch (path) {
        case '1':
          return 'image51';
        case '2':
          return 'image52';
        case '3':
          return 'image53';
        case '4':
          return 'image54';
        case '5':
          return 'image55';
        default:
          return '';
      }
    }else{
      switch (path) {
        case '1':
          return 'image31';
        case '2':
          return 'image32';
        case '3':
          return 'image33';
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
