import 'dart:convert';

import 'package:http/http.dart' as http;

class DallE {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");

  static generateImage(String imagePrompt, String size, String apiKey) async{
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
    print(res.statusCode);
    if(res.statusCode == 200){
      var data = jsonDecode(res.body.toString());
      return data['data'][0]['url'].toString();
    }else{
      print("Dall-E API call Error");
    }
  }
}