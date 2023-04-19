import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt/constants/api_const.dart';
import 'package:chatgpt/models/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse(" $Base_url/models"),
        headers: {"Authorization": "Bearer $Api_key"},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      // print("json response $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        // log("temp ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
