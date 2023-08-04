import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:liquid_art_ai/src/features/apikey_repository/presentation/apikey_repository_page.dart';
import 'package:liquid_art_ai/src/features/connection/infrastructure/galaxy_cubit.dart';
import 'package:liquid_art_ai/src/features/drawer/presentation/pages/drawer_page.dart';
import 'package:liquid_art_ai/src/features/gallery/presentation/pages/galley_page.dart';
import 'package:liquid_art_ai/src/features/home/presentation/page/home_page.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_button.dart';
import 'package:liquid_art_ai/src/widgets/liquid_art_text_field.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final GalaxyCubit _galaxyCubit = GalaxyCubit();

  // @override
  // void initState() {
  //   _galaxyCubit = context.read();
  //   super.initState();
  // }

  //Text Strings
  final String connectionPageTitle = "Connection";

  var hostnameController = TextEditingController();
  var ipAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var lgScreensController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalaxyCubit, GalaxyState>(
      bloc: _galaxyCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              connectionPageTitle,
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: ListView(
                children: [
                  LiquidArtTextField(
                    label: 'Liquid Galaxy Host Name',
                    hintText: 'Ex: lg',
                    textController: hostnameController,
                    onChanged: (value) => _galaxyCubit.passwordChanged(value),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LiquidArtTextField(
                    label: 'Liquid Galaxy IP Address',
                    hintText: 'Ex: 172.16.51.173',
                    textController: ipAddressController,
                    onChanged: (value) => _galaxyCubit.ipAddressChanged(value),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LiquidArtTextField(
                    label: 'Liquid Galaxy Host Password',
                    hintText: 'Ex: lq',
                    textController: passwordController,
                    onChanged: (value) => _galaxyCubit.passwordChanged(value),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  LiquidArtTextField(
                    inputType: TextInputType.number,
                    label: 'Number of Screens',
                    hintText: 'Ex: 5',
                    textController: lgScreensController,
                    onChanged: (value) =>
                        _galaxyCubit.lgScreensChanged(int.parse(value)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (state.loading) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                  if (state.errorMessage != null) ...[
                    Center(
                      child: Text(state.errorMessage!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                  Center(
                    child: LiquidArtButton(
                      label: 'Connect With Galaxy',
                      onTap: state.loading
                          // ||
                          // state.client != null && !state.client!.isClosed
                          ? null
                          : () => _galaxyCubit.connect(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 15,
                          children: [
                            // LiquidArtButton(
                            //   label: 'Reboot',
                            //   onTap: state.client != null &&
                            //           !state.client!.isClosed
                            //       ? () => _galaxyCubit.reboot()
                            //       : null,
                            // ),
                            // LiquidArtButton(
                            //   label: 'Shutdown',
                            //   onTap: state.client != null &&
                            //           !state.client!.isClosed
                            //       ? () => _galaxyCubit.shutdown()
                            //       : null,
                            // ),
                            // LiquidArtButton(
                            //   label: 'Test',
                            //   onTap: state.client != null &&
                            //           !state.client!.isClosed
                            //       ? () => _galaxyCubit.sayHi()
                            //       : null,
                            // ),
                            LiquidArtButton(
                              label: 'Open Canvas',
                              onTap: state.client != null &&
                                      !state.client!.isClosed
                                  ? () => _galaxyCubit.openCanvas()
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
      },
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
