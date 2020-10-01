import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:films/src/models/films_model.dart';

class FilmsProvider{
  String _apiKey = 'd557e5df9ba35fd2aa6f664302388244';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Film>> getInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    final response =  await http.get(url);
    final decodeData = json.decode(response.body);
    final films= new Films.fromJsonList(decodeData['results']);
   // print(films.items[0].title)
    return films.items;
  }

}