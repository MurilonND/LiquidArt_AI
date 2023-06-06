import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liquid_art_ai/env.dart';

class DallE {
  static final url = Uri.parse("uri");

  static final headers = {
    "ContentType": "application/json",
    "Authorization": "Bearer $apiKey"
  };

  static generateImage(String text, String size) async{
    final body = jsonEncode(
      {
        "prompt": text,
        "n": 1,
        "size": size
      },
    );

    var res = await http.post(url, headers: headers, body: body,);

    if(res.statusCode == 200){
      var data = jsonDecode(res.body.toString());
      print(data);
    }else{
      print("Dall-E API call Error");
    }
  }
}