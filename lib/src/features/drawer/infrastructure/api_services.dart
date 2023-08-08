import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:liquid_art_ai/src/utils/snack_bar_messager.dart';
import 'package:liquid_art_ai/src/utils/user_configurations.dart';

class DallE {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");

  static generateImage(context, String imagePrompt, String size, String apiKey) async{
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    final body = jsonEncode(
      {
        "prompt": imagePrompt,
        "n": 1,
        "size": size
      },
    );

    var res = await http.post(url, headers: headers, body: body,);
    print(res);
    if(res.statusCode == 200){
      WarningSnackBar.apiCallSuccess(context);
      var data = jsonDecode(res.body.toString());
      print(res);
      return data['data'][0]['url'].toString();
    }else{
      WarningSnackBar.apiCallError(context, res.body.toString());
    }
  }
}

class StableDiffusion {
  static final url = Uri.parse("http://172.17.56.174:8110/sdapi/v1/txt2img");

  static generateImage(context ,String imagePrompt, String size) async{
    final height = int.parse(size.split("x").first);
    final width = int.parse(size.split("x").last);

    final body = jsonEncode(
        {
          "prompt": imagePrompt,
          "width": width,
          "height": height
        }
    );

    var res = await http.post(url, body: body,);
    if(res.statusCode == 200){
      WarningSnackBar.apiCallSuccess(context);
      var data = jsonDecode(res.body.toString());
      return data['images'][0].toString();
    }else{
      var data = jsonDecode(res.body.toString());
      WarningSnackBar.apiCallError(context, data.toString());
    }
  }
}