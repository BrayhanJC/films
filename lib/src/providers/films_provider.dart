import 'dart:async';
import 'dart:convert';

import 'package:films/src/models/Actors_models.dart';
import 'package:http/http.dart' as http;
import 'package:films/src/models/films_model.dart';

class FilmsProvider {
  String _apiKey = 'd557e5df9ba35fd2aa6f664302388244';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 1;
  int _mainPage = 0;
  bool _loading = false;

  List<Film> _populares = new List();

  final _popularesStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Film>> get popularStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Uri getUrlApi(String url, String nameUrl, String numberPage) {
    final resultUrl = Uri.https(url, nameUrl,
        {'api_key': _apiKey, 'language': _language, 'page': numberPage});
    return resultUrl;
  }

  Future<List<Film>> processResponse(String nameUrl, String query) async {
    final url = Uri.https(_url, nameUrl,
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final films = new Films.fromJsonList(decodeData['results']);
    // print(films.items[0].title)

    return films.items;
  }

  Future<List<Film>> returnFilms(String nameUrl, String numberPage) async {
    final url = getUrlApi(_url, nameUrl, numberPage);
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final films = new Films.fromJsonList(decodeData['results']);
    // print(films.items[0].title)

    return films.items;
  }

  Future<List<Film>> getInCinemas() async {
    _mainPage++;
    return await returnFilms('3/movie/now_playing', _mainPage.toString());
  }

  Future<List<Film>> getPopulars() async {
    if (_loading) return [];
    _loading = true;
    _popularesPage++;
    final resp =
        await returnFilms('3/movie/popular', _popularesPage.toString());
    _populares.addAll(resp);
    popularesSink(_populares);
    _loading = false;
    return resp;
  }

  Future<List<Actor>> getActor(String filmId) async {
    final url = Uri.https(_url, '3/movie/$filmId/credits',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final actor = new Actors.fromJsonList(decodedData['cast']);
    return actor.actores;
  }

  Future<List<Film>> searchFilm(String query) async {
    return await processResponse('3/search/movie', query.toString());
  }
}
