import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_art_ai/server.dart';
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
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a loading process
    Timer(const Duration(seconds: 5), () {
      // After the delay, navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo/splash.png'),
      ),
    );
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

  shelf_io
      .serve((shelf.Request request) => imageServer.handleRequest(request),
          address, port)
      .then((server) {
    print('Image server running on ${server.address.host}:${server.port}');
  });
}
