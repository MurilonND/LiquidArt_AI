import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/gallery/presentation/pages/galley_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/features/settings/presentation/page/settings_page.dart';
import 'package:liquid_art_ai/src/widgets/my_button.dart';
import 'package:liquid_art_ai/src/widgets/my_input_field.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Drawer",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    // width: double.infinity,
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Flexible(
                              flex: 4,
                              child: MyInputField(
                                  label: 'AI Model', initialInput: 'AI Model'),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: MyInputField(
                                  label: 'Size', initialInput: 'Size'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const MyInputField(
                            label: 'API Key', initialInput: 'API Key'),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Flexible(
                              flex: 2,
                              child: MyInputField(
                                  label: 'Batch Count',
                                  initialInput: 'Batch Count'),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: MyInputField(
                                  label: 'Batch Size',
                                  initialInput: 'Batch Size'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const MyInputField(
                            label: 'Image Prompt',
                            initialInput: 'Image Prompt'),
                        const SizedBox(
                          height: 5,
                        ),
                        const MyInputField(
                            label: 'Negative Prompt',
                            initialInput: 'Negative Prompt'),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Flexible(
                              flex: 4,
                              child: MyInputField(
                                  label: 'Seed', initialInput: 'Seed'),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: MyInputField(
                                  label: 'CFG Scale',
                                  initialInput: 'CFG Scale'),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/logo/Logo.png'),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: MyButton(
                          label: 'Save Image Generated',
                        ),
                      )
                    ],
                  )
                )
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
              const Icon(
                Icons.home,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }),
          _buildSpeedDial(
              context,
              const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          }),
          _buildSpeedDial(
              context,
              const Icon(
                Icons.image,
                color: Colors.white,
              ),
              const Color(0xFF4C7BBF),
                  () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const GalleryPage()),
                );
              }),
        ],
      ),
    );
  }
}

_buildSpeedDial(context, Icon icon, Color backgroundColor, Function function) {
  return SpeedDialChild(
    child: icon,
    backgroundColor: backgroundColor,
    onTap: () {
      function();
    },
  );
}
