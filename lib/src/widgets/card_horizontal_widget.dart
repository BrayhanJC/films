import 'package:films/src/models/films_model.dart';
import 'package:flutter/material.dart';

class CardHorizontal extends StatelessWidget {
  final List<Film> films;
  final Function nextPage;

  CardHorizontal({@required this.films, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
        if (_pageController.position.pixels >= _pageController.position.maxScrollExtent -200){
              nextPage();
        }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context),
        itemCount: films.length,
        itemBuilder: (context, i) => _card(context, films[i]),
      ),
    );
  }



  Widget _card(BuildContext context, Film film) {
    //return film.map((film) {
      return Container(
          margin: EdgeInsets.only(right: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(film.getPosterImg()),
                    fit: BoxFit.cover,
                    height: 160,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(film.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption)
            ],
          ));
    //}).toList();
  }
}
