import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:liquid_art_ai/src/features/connection/infrastructure/galaxy_cubit.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/utils/user_configurations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserConfigurations.init();

  startImageServer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => GalaxyCubit())
      ],
      child: MaterialApp(
        title: 'Liquid Art AI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class ImageServer {
  Future<shelf.Response> handleRequest(shelf.Request request) async {
      final imageBytes = await _getImageBytes(); // Retrieve image bytes from your source

      if (imageBytes != null) {
        return shelf.Response.ok(imageBytes, headers: {'content-type': 'image/png'});
      } else {
        return shelf.Response.notFound('Image not found');
      }
  }

  Future<Uint8List> _getImageBytes() async {
    try {
      final ByteData byteData = await rootBundle.load('assets/logo/Logo.png');
      return byteData.buffer.asUint8List();
    } catch (e) {
      print('Error reading image file: $e');
      return Uint8List(0);
    }
  }
}

void startImageServer() async {
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

  shelf_io.serve((shelf.Request request) => imageServer.handleRequest(request), address, port).then((server) {
    print('Image server running on ${server.address.host}:${server.port}');
  });
}
