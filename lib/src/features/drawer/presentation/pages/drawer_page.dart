import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/drawer/infrastructure/api_services.dart';
import 'package:liquid_art_ai/src/features/gallery/presentation/pages/galley_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/features/settings/presentation/page/settings_page.dart';
import 'package:liquid_art_ai/src/widgets/my_button.dart';
import 'package:liquid_art_ai/src/widgets/my_dropdown.dart';
import 'package:liquid_art_ai/src/widgets/my_input_field.dart';

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
                          children: [
                            Flexible(
                              flex: 4,
                              child: MyInputField(
                                label: 'AI Model',
                                initialInput: 'AI Model',
                                textController: textController,
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: MyDropDown(
                                label: "Size",
                                dropValue: sizeValue,
                                hintText: "Size",
                                values: sizeValues,
                                items: sizes,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyInputField(
                          label: 'API Key',
                          initialInput: 'API Key',
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
                              child: MyInputField(
                                label: 'Batch Count',
                                initialInput: 'Batch Count',
                                textController: textController,
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: MyInputField(
                                label: 'Batch Size',
                                initialInput: 'Batch Size',
                                textController: textController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyInputField(
                          label: 'Image Prompt',
                          initialInput: 'Image Prompt',
                          textController: textController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyInputField(
                          label: 'Negative Prompt',
                          initialInput: 'Negative Prompt',
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
                              child: MyInputField(
                                label: 'Seed',
                                initialInput: 'Seed',
                                textController: textController,
                              ),
                            ),
                            const Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 2,
                              child: MyInputField(
                                label: 'CFG Scale',
                                initialInput: 'CFG Scale',
                                textController: textController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            label: 'Generate Image',
                            onTap: () {},
                          ),
                        )
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: MyButton(
                          label: 'Send Image to Gallery',
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
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
