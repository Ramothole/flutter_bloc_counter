import 'dart:convert';
import 'dart:io';

import 'package:CounterApp/Question3/model/Rick_and_morty_model.dart';
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

  static Future<Result> getSingleCharacter(int id) async {
    try {
      Response response = await http.get(
        Uri.parse("https://rickandmortyapi.com/api/character/$id"),
      );
      return Result.fromJson(json.decode(response.body));
    } on HttpException {
      rethrow;
    }
  }
}
