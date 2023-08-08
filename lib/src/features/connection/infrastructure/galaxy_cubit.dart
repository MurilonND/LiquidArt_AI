import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_art_ai/server.dart';
import 'package:network_info_plus/network_info_plus.dart';

part 'galaxy_state.dart';

class GalaxyCubit extends Cubit<GalaxyState> {
  GalaxyCubit() : super(const GalaxyState());

  void lgScreensChanged(int value) {
    final newState = state.copyWith(
      lgScreens: value,
    );
    emit(newState);
  }

  void hostNameChanged(String value) {
    final newState = state.copyWith(
      hostname: value,
    );
    emit(newState);
  }

  void ipAddressChanged(String value) {
    final newState = state.copyWith(
      ipAddress: value,
    );
    emit(newState);
  }

  void portChanged(int value) {
    final newState = state.copyWith(
      port: value,
    );
    emit(newState);
  }

  void passwordChanged(String value) {
    final newState = state.copyWith(
      password: value,
    );
    emit(newState);
  }

  void dalleKeyChanged(String value) {
    final newState = state.copyWith(
      dalleKey: value,
    );
    emit(newState);
  }

  void ipAddressLocalMachineChanged(String value) {
    final newState = state.copyWith(
      ipAddressLocalMachine: value,
    );
    emit(newState);
  }

  void portLocalMachineChanged(String value) {
    final newState = state.copyWith(
      portLocalMachine: value,
    );
    emit(newState);
  }

  Future<void> connect() async {
    final newState = state.copyWith(
      errorMessage: null,
    );
    emit(newState);

    if (!state.formIsValid) {
      return emit(state.copyWith(
        showErrors: true,
        errorMessage: 'invalid Form',
      ));
    }

    emit(state.copyWith(
      loading: true,
    ));

    // close client if its already connected
    if (state.client != null && !state.client!.isClosed) {
      emit(state.copyWith(
        errorMessage: 'already connected, closing client',
      ));
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
        errorMessage: e.toString(),
      ));
    } on SocketException catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> shutdown() async {
    if (state.client == null || state.client!.isClosed) return;

      final closeCanvasCommand = 'bash <(curl -S https://raw.githubusercontent.com/MurilonND/LiquidArt_AI/main/scripts/close.sh) ' +
          state.password;
      final close = await state.client!.execute(closeCanvasCommand);
      await close.stdin.close();
      await close.done;
  }

  Future<void> openCanvas(String? imagePath, Uint8List? imageFileBytes) async {
    final networkInfo = NetworkInfo();
    String? wifiIPv4 = '';

    try {
      wifiIPv4 = await networkInfo.getWifiIP();
    } catch (e) {
      wifiIPv4 = '';
    }

    rerunImageServer(imagePath, state.lgScreens, imageFileBytes);

    final closeCanvasCommand = 'bash <(curl -S https://raw.githubusercontent.com/MurilonND/LiquidArt_AI/main/scripts/close.sh) ' +
        state.password;
    final close = await state.client!.execute(closeCanvasCommand);
    await close.stdin.close();
    await close.done;

    final openCanvasCommand =
        'bash <(curl -S https://raw.githubusercontent.com/MurilonND/LiquidArt_AI/main/scripts/open.sh) ' +
            state.password +
            ' ' +
            wifiIPv4!;
    final session = await state.client!.execute(openCanvasCommand);
    await session.stdin.close();
    await session.done;
  }
}
