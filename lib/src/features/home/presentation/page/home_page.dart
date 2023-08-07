import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/apikey_repository/presentation/apikey_repository_page.dart';
import 'package:liquid_art_ai/src/features/drawer/presentation/pages/drawer_page.dart';
import 'package:liquid_art_ai/src/features/gallery/presentation/pages/galley_page.dart';
import 'package:liquid_art_ai/src/features/connection/presentation/page/connection_page.dart';
import 'package:network_info_plus/network_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Container(
                    // width: double.infinity,
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Welcome To LiquidArt AI!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'First to start click in the round button in the bottom and go to the configuration page, there fill the field with the right data to connect with the Liquid Galaxy then you can go to the draw page and start creating your own images!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Image.asset('assets/logo/Logo.png'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color(0xFF4C7BBF),
        children: [
          _buildSpeedDial(
              context,
              'Connection Page',
              const Icon(
                Icons.cast_connected,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ConnectionPage()),
            );
          }),
          _buildSpeedDial(
              context,
              'Drawer Page',
              const Icon(
                Icons.brush,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const DrawerPage()),
            );
          }),
          _buildSpeedDial(
              context,
              'Gallery Page',
              const Icon(
                Icons.image,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const GalleryPage()),
            );
          }),
          _buildSpeedDial(
              context,
              'API Keys',
              const Icon(
                Icons.key,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const ApiKeyRepositoryPage()),
            );
          }),
        ],
      ),
    );
  }

  Future<String> getConnectionDoor() async {
    final networkInfo = NetworkInfo();
    String? wifiIPv4 = '';

    try {
      wifiIPv4 = await networkInfo.getWifiIP();
    } catch (e) {
      wifiIPv4 = 'Failed to get Wifi IPv4 error: $e';
    }

    return wifiIPv4!;
  }
}

_buildSpeedDial(context, String label, Icon icon, Color backgroundColor,
    Function function) {
  return SpeedDialChild(
    label: label,
    child: icon,
    backgroundColor: backgroundColor,
    onTap: () {
      function();
    },
  );
}
