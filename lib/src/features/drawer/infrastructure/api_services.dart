import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liquid_art_ai/src/utils/user_configurations.dart';

class DallE {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");

  static generateImage(String imagePrompt, String size) async{
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${UserConfigurations.getDallEKey()}"
    };

    final body = jsonEncode(
      {
        "prompt": imagePrompt,
        "n": 1,
        "size": size
      },
    );

    var res = await http.post(url, headers: headers, body: body,);
    if(res.statusCode == 200){
      var data = jsonDecode(res.body.toString());
      return data['data'][0]['url'].toString();
    }else{
    }
  }
}

class StableDiffusion {
  static final url = Uri.parse("http://127.0.0.1:7860/sdapi/v1/txt2img");

  static generateImage(String imagePrompt, String size) async{
    final height = size.split("x").first;
    final width = size.split("x").last;

    final body = jsonEncode(
      {
        "prompt": imagePrompt,
        "width": width,
        "height": height
      },
    );

    var res = await http.post(url, body: body,);
    if(res.statusCode == 200){
      var data = jsonDecode(res.body.toString());
      return data['data'][0]['url'].toString();
    }else{
    }
  }
}