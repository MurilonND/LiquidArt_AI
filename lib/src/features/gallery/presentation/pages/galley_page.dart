import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/apikey_repository/presentation/apikey_repository_page.dart';
import 'package:liquid_art_ai/src/features/drawer/presentation/pages/drawer_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/features/connection/presentation/page/connection_page.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_button.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_text_field.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gallery",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery
                      .of(context)
                      .size
                      .width > MediaQuery
                      .of(context)
                      .size
                      .height ? MediaQuery
                      .of(context)
                      .size
                      .width*3/5 : MediaQuery
                      .of(context)
                      .size
                      .width),
                  child: Container(
                    // width: double.infinity,
                    padding: const EdgeInsets.all(50),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: 4,
                        itemBuilder: (context, index) => const FlutterLogo()),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width > MediaQuery
                    .of(context)
                    .size
                    .height ? MediaQuery
                    .of(context)
                    .size
                    .width/4 : MediaQuery
                    .of(context)
                    .size
                    .width,),
                child: Column(
                  children: [
                    LiquidArtTextField(label: 'Search by Prompt',
                        hintText: 'Search by Prompt',
                        textController: textController),
                    const SizedBox(
                      height: 40,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        LiquidArtButton(
                          label: 'Show on Liquid Galaxy', onTap: () {},),
                        LiquidArtButton(
                          label: 'Share the Image', onTap: () {},),
                        LiquidArtButton(
                          label: 'Download the Image', onTap: () {},),
                      ],
                    ),
                  ],
                ),
              ),

            ],
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
