import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/apikey_repository/presentation/apikey_repository_page.dart';
import 'package:liquid_art_ai/src/features/drawer/presentation/pages/drawer_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/features/connection/presentation/page/connection_page.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_button.dart';
// import 'package:liquid_art_ai/src/widgets/liquid_art_text_field.dart';
import 'package:path_provider/path_provider.dart';

import '../../../connection/infrastructure/galaxy_cubit.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late GalaxyCubit _galaxyCubit;

  bool isLoading = false;

  List imgList = [];

  getImages() async {
    setState(() {
      isLoading = true;
    });
    const folder = "LiquidArtAI";
    final path = await getApplicationDocumentsDirectory();
    final directory = Directory('${path.path}/$folder');

    setState(() {
      imgList = directory.listSync();
      isLoading = false;
    });
  }

  popImage(File filePath) {
    showDialog(
        context: context,
        builder: (context) =>
            Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.file(filePath),
                  ),
                  const SizedBox(height: 20,),
                  if(filePath.toString().split('/').last.split('.').first.split('-').last.split('x').first == filePath.toString().split('/').last.split('.').first.split('-').last.split('x').last)...[
                    const Text("The size of the image isn't appropriated for the galaxy, distortions will happen", textAlign: TextAlign.center, style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
                    const SizedBox(height: 20,),
                  ],
                  if(!(_galaxyCubit.state.client != null && !_galaxyCubit.state.client!.isClosed))...[
                    const Text("There is no connection with a Liquid Galaxy machine, please go to connection page", textAlign: TextAlign.center, style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
                    const SizedBox(height: 20,),
                  ],
                   LiquidArtButton(label: 'Show on Liquid Galaxy',
                          onTap: _galaxyCubit.state.client != null && !_galaxyCubit.state.client!.isClosed? () async {
                            File file = filePath;
                            Uint8List bytes = await fileToBytes(file);

                            _galaxyCubit.openCanvas(null, bytes);
                          } : null

                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    _galaxyCubit = context.read<GalaxyCubit>();
    getImages();
  }

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
        child: SingleChildScrollView(
          child: Container(
            // width: double.infinity,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(isLoading)...[
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ]else...[
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                          MediaQuery
                              .of(context)
                              .size
                              .width > 500 ? 3 : 2),
                      itemCount: imgList.length,
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                            child: InkWell(
                              onTap: () {
                                popImage(imgList[index]);
                              },
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.file(imgList[index]),
                              ),
                            ),
                          ),),
                ]
              ],
            )
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color(0xFF4C7BBF),
        children: [
          _buildSpeedDial(
              context,
              'Home Page',
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

  Future<Uint8List> fileToBytes(File file) async {
      // Read the file as bytes using the readAsBytes method
      List<int> bytes = await file.readAsBytes();

      // Convert the list of bytes to Uint8List using ByteData
      Uint8List uint8List = Uint8List.fromList(bytes);

      return uint8List;
    }
  }

_buildSpeedDial(context, String label, Icon icon, Color backgroundColor, Function function) {
  return SpeedDialChild(
    label: label,
    child: icon,
    backgroundColor: backgroundColor,
    onTap: () {
      function();
    },
  );
}
