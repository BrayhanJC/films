import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:films/src/models/films_model.dart';

class FilmsProvider {
  String _apiKey = 'd557e5df9ba35fd2aa6f664302388244';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Uri getUrlApi(String url, String nameUrl) {
    final resultUrl =
        Uri.https(url, nameUrl, {'api_key': _apiKey, 'language': _language});
    return resultUrl;
  }

  Future<List<Film>> returnFilms(String nameUrl) async {
    final url = getUrlApi(_url, nameUrl);
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final films = new Films.fromJsonList(decodeData['results']);
    // print(films.items[0].title)
    return films.items;
  }

  Future<List<Film>> getInCinemas() async {
    // print(films.items[0].title)
    return await returnFilms('3/movie/now_playing');
  }

  Future<List<Film>> getPopulars() async {
    return await returnFilms('3/movie/popular');
  }
}
