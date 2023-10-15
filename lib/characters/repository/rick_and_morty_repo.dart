
import 'dart:convert';
import 'dart:io';

import 'package:CounterApp/characters/model/Rick_and_morty_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RickMortysRepository {
  static Future<RickyAndMortyModel> fetchCharacterList() async {
    try {
      Response response = await http.get(
        Uri.parse("https://rickandmortyapi.com/api/character"),
      );

      return RickyAndMortyModel.fromJson(json.decode(response.body));
    } on HttpException {
      rethrow;
    }
  }
}
