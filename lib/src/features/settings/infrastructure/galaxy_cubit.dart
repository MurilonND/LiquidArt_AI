import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'galaxy_state.dart';

class GalaxyCubit extends Cubit<GalaxyState> {
  GalaxyCubit() : super(const GalaxyState());

  void ipAddressChanged(String value) {
    final newState = state.copyWith(
      ipAddress: value,
    );
    emit(newState);
  }

  void passwordChanged(String value) {
    final newState = state.copyWith(
      password: value,
    );
    emit(newState);
  }

  Future<void> connect() async {
    if (!state.formIsValid) {
      return emit(state.copyWith(showErrors: true));
    }

    emit(state.copyWith(
      loading: true,
    ));

    // close client if its already connected
    if (state.client != null && !state.client!.isClosed) {
      print('already connected, closing client');
      state.client!.close();
    }

    late SSHClient client;
    try {
      final socket = await SSHSocket.connect(state.ipAddress, state.port);
      client = SSHClient(
        socket,
        username: state.hostname,
        onPasswordRequest: () => state.password,
      );
      await client.authenticated;

      emit(state.copyWith(
        client: client,
        showErrors: false,
        loading: false,
      ));
    } on SSHAuthFailError catch (e) {
      debugPrint(e.toString());
      client.close();
      emit(state.copyWith(
        loading: false,
      ));
    } on SocketException catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        loading: false,
      ));
    }
  }

  Future<void> shutdown() async {
    if (state.client == null || state.client!.isClosed) return;

    final shutdownCommand =
        'bash <(curl -s https://raw.githubusercontent.com/LiquidGalaxyLAB/BIM-Liquid-Galaxy-Visualizer/main/bim_visualizer_node/libs/shutdown.sh) ${state.password}';
    final session = await state.client!.execute(shutdownCommand);
    await session.stdin.close();
    await session.done;
  }

  Future<void> sayHi() async {
    final sayHiCommand = 'echo hi';

    final session =
        await state.client!.execute('export DISPLAY=:0 && $sayHiCommand');
    await session.stdin.close();
    await session.done;
  }

  Future<void> reboot() async {
    if (state.client == null || state.client!.isClosed) return;

    final shutdownCommand =
        'bash <(curl -s https://raw.githubusercontent.com/LiquidGalaxyLAB/BIM-Liquid-Galaxy-Visualizer/main/bim_visualizer_node/libs/reboot.sh) ${state.password}';
    final session = await state.client!.execute(shutdownCommand);
    await session.stdin.close();
    await session.done;
  }

  Future<void> relaunchEarth() async {
    if (state.client == null || state.client!.isClosed) return;

    final shutdownCommand =
        'bash <(curl -s https://raw.githubusercontent.com/LiquidGalaxyLAB/BIM-Liquid-Galaxy-Visualizer/main/bim_visualizer_node/libs/relaunch.sh) ${state.password}';
    final session = await state.client!.execute(shutdownCommand);
    await session.stdin.close();
    await session.done;
  }
}
