import 'package:films/src/pages/film_detail.dart';
import 'package:films/src/pages/home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes:{
        '/': (BuildContext context) => HomePage(),
        'detailFilm': (BuildContext context) => FilmDetail(),
      },

    );
  }
}