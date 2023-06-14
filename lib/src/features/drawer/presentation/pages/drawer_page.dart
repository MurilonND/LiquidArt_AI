import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/drawer/infrastructure/api_services.dart';
import 'package:liquid_art_ai/src/features/gallery/presentation/pages/galley_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/features/settings/presentation/page/settings_page.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_button.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_dropdown.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_text_field.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  List<String> modes = ["DallE"];
  List<String> modelValues = ["DallE"];
  String? modelValue;

  List<String> sizes = ["Small", "Medium", "Large"];
  List<String> sizeValues = ["256x256", "512x512", "1024x1024"];
  String? sizeValue;

  List<String> batchCount = ["0"];
  List<String> batchCountValues = ["0"];
  String? batchCountValue;

  List<String> batchSize = ["0"];
  List<String> batchSizeValues = ["0"];
  String? batchSizeValue;

  List<String> scale = ["0"];
  List<String> scaleValues = ["0"];
  String? scaleValue;

  String image = "";

  var textController = TextEditingController();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    // width: double.infinity,
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              child: LiquidArtTextField(
                                label: 'AI Model',
                                hintText: 'AI Model',
                                textController: textController,
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: LiquidArtDropDown(
                                label: "Size",
                                dropValue: sizeValue,
                                hintText: "Size",
                                values: sizeValues,
                                items: sizes,
                                onChanged: (value) {
                                  setState(() {
                                    sizeValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LiquidArtTextField(
                          enabled: false,
                          label: 'API Key',
                          hintText: 'API Key',
                          textController: textController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: LiquidArtTextField(
                                enabled: false,
                                label: 'Batch Count',
                                hintText: 'Batch Count',
                                textController: textController,
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: LiquidArtTextField(
                                enabled: false,
                                label: 'Batch Size',
                                hintText: 'Batch Size',
                                textController: textController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LiquidArtTextField(
                          label: 'Image Prompt',
                          hintText: 'Image Prompt',
                          textController: textController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LiquidArtTextField(
                          enabled: false,
                          label: 'Negative Prompt',
                          hintText: 'Negative Prompt',
                          textController: textController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              child: LiquidArtTextField(
                                enabled: false,
                                label: 'Seed',
                                hintText: 'Seed',
                                textController: textController,
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: LiquidArtTextField(
                                enabled: false,
                                label: 'CFG Scale',
                                hintText: 'CFG Scale',
                                textController: textController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        LiquidArtButton(
                          label: 'Generate Image',
                          onTap: true ? () {} : null,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/Logo.png'),
                    const SizedBox(height: 20),
                    LiquidArtButton(
                      label: 'Send Image to Gallery',
                      onTap: false ? () {} : null,
                    )
                  ],
                ),
              ),
            ],
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
              const Color(0xFF4C7BBF), () {
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
