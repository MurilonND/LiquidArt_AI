import 'package:flutter/material.dart';

class WarningSnackBar {
  static void apiCallError(context, String errorMessage){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: const TextStyle(fontSize: 20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void apiCallSuccess(context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'API Call was made with success',
          style: TextStyle(fontSize: 20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.green,
      ),
    );
  }
}