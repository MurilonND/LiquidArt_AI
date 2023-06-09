import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/apikey_repository/presentation/apikey_repository_page.dart';
import 'package:liquid_art_ai/src/features/drawer/infrastructure/api_services.dart';
import 'package:liquid_art_ai/src/features/gallery/presentation/pages/galley_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/features/connection/presentation/page/connection_page.dart';
import 'package:liquid_art_ai/src/utils/user_configurations.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_button.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_dropdown.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_text_field.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  List<String> modes = ["Dall-E", "Stable-Diffusion"];
  List<String> modelValues = ["dall_e", "stable_diffusion"];
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
  bool isLoaded = false;
  bool placeHolder = true;

  var textController = TextEditingController();

  TextEditingController? _imagePromptController;

  @override
  void initState() {
    _imagePromptController = TextEditingController(text: '');

    super.initState();
  }

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
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Container(
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
                              child: LiquidArtDropDown(
                                label: "AI Model",
                                dropValue: modelValue,
                                hintText: "AI Model",
                                values: modelValues,
                                items: modes,
                                onChanged: (value) {
                                  setState(() {
                                    modelValue = value;
                                  });
                                },
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text(
                                'Image Prompt',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            TextField(
                              controller: _imagePromptController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                  hintText: 'Image Prompt',
                                  fillColor: Colors.white70),
                            )
                          ],
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
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     const Padding(
                        //       padding: EdgeInsets.only(left: 0),
                        //       child: Text(
                        //         'API Key',
                        //         style: TextStyle(
                        //             fontSize: 18, color: Colors.black),
                        //       ),
                        //     ),
                        //     TextField(
                        //       controller: _apiKeyController,
                        //       decoration: InputDecoration(
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(20.0),
                        //             borderSide:
                        //                 const BorderSide(color: Colors.black),
                        //           ),
                        //           filled: true,
                        //           hintStyle: const TextStyle(
                        //               fontSize: 16, color: Colors.grey),
                        //           hintText: 'API Key',
                        //           fillColor: Colors.white70),
                        //     )
                        //   ],
                        // ),
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
                        Center(
                          child: LiquidArtButton(
                            label: 'Generate Image',
                            onTap: modelValue != null &&
                                    sizeValue != null &&
                                    _imagePromptController!.text.isNotEmpty &&
                                    UserConfigurations.getDallEKey() != ""
                                ? () async {
                                    setState(() {
                                      isLoaded = false;
                                      placeHolder = false;
                                    });
                                    if (modelValue == "dall_e") {
                                      image = await DallE.generateImage(
                                          _imagePromptController!.text,
                                          sizeValue!);
                                    } else {
                                      image =
                                          await StableDiffusion.generateImage(
                                              _imagePromptController!.text,
                                              sizeValue!);
                                    }
                                    setState(() {
                                      isLoaded = true;
                                    });
                                  }
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoaded) ...[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(image))
                      ] else ...[
                        if (placeHolder) ...[
                          Image.asset('assets/logo/Logo.png')
                        ] else ...[
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          const SizedBox(height: 30,)
                        ]
                      ],
                      const SizedBox(height: 20),
                      LiquidArtButton(
                        label: 'Send Image to Gallery',
                        onTap: false ? () {} : null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }),
          _buildSpeedDial(
              context,
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
