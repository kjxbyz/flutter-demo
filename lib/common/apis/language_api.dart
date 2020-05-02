import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_demo/common/model/language_model.dart';

class LanguageAPi {
  static Future<List<Language>> fetch() async {
    var url = 'https://api.kjxbyz.com/languages.json';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      if(result != null && result.length > 0) {
        List<Language> items = [];
        result.forEach((v) {
          items.add(Language.fromJson(v));
        });
        return items;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return [];
  }
}
