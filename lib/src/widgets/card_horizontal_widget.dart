import 'package:films/src/models/films_model.dart';
import 'package:flutter/material.dart';

class CardHorizontal extends StatelessWidget {
  final List<Film> films;

  CardHorizontal({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          
          initialPage:1,
          viewportFraction: 0.3
        ),
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(context) {
    return films.map((film) {
      return Container(
          margin: EdgeInsets.only(right: 10),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(film.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160,
                ),
              ),
              SizedBox(height:5),
              Text(film.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption)
            ],
          ));
    }).toList();
  }
}
