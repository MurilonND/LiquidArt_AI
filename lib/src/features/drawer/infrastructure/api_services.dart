import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liquid_art_ai/src/utils/snack_bar_messager.dart';

class DallE {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");

  static generateImage(
      context, String imagePrompt, String size, String apiKey) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    final body = jsonEncode(
      {"prompt": imagePrompt, "n": 1, "size": size},
    );

    var res = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (res.statusCode == 200) {
      WarningSnackBar.apiCallSuccess(context);
      var data = jsonDecode(res.body.toString());
      return data['data'][0]['url'].toString();
    } else {
      WarningSnackBar.apiCallError(context, res.body.toString());
    }
  }
}

class StableDiffusion {
  static generateImage(context, String imagePrompt, String size,
      String ipAddressLocalMachine, String portLocalMachine) async {
    final url = Uri.parse(
        "http://$ipAddressLocalMachine:$portLocalMachine/sdapi/v1/txt2img");

    final height = int.parse(size.split("x").first);
    final width = int.parse(size.split("x").last);

    final body =
        jsonEncode({"prompt": imagePrompt, "width": width, "height": height});

    var res = await http.post(
      url,
      body: body,
    );
    if (res.statusCode == 200) {
      WarningSnackBar.apiCallSuccess(context);
      var data = jsonDecode(res.body.toString());
      return data['images'][0].toString();
    } else {
      var data = jsonDecode(res.body.toString());
      WarningSnackBar.apiCallError(context, data.toString());
    }
  }
}

class Leap {
  static generateImage(context, String imagePrompt, String size, String apiKey, String modelId) async {
    final url = Uri.parse(
        "https://api.tryleap.ai/api/v1/images/models/$modelId/inferences");

    final height = int.parse(size.split("x").first);
    final width = int.parse(size.split("x").last);

    final headers = {
      "accept": "application/json",
      "content-type": "application/json",
      "authorization": "Bearer $apiKey"
    };

    final body = jsonEncode({
      "prompt": imagePrompt,
      "steps": 50,
      "width": width,
      "height": height,
      "numberOfImages": 1,
      "promptStrength": 7,
      "enhancePrompt": false,
      "restoreFaces": true,
      "upscaleBy": "x1"
    });

    var res = await http.post(
      url,
      headers: headers,
      body: body,
    );
    var data = jsonDecode(res.body.toString());
    var inferenceId = data["id"];

    if (data['status'] == 'queued') {
      WarningSnackBar.apiCallSuccess(context);

      final url = Uri.parse(
          "https://api.tryleap.ai/api/v1/images/models/$modelId/inferences/$inferenceId");

      var res = await http.get(url, headers: headers);
      var data = jsonDecode(res.body.toString());

      while (data['state'].toString() != "finished") {
        res = await http.get(url, headers: headers);
        data = jsonDecode(res.body.toString());
      }

      var image = data["images"][0]['uri'].toString();

      return image;
    } else {
      WarningSnackBar.apiCallError(context, data.toString());
    }
  }
}
