import 'package:films/src/models/films_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Film> films;

  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    double _width = _screenSize.width * 0.6;
    double height = _screenSize.height * 0.5;
    return Container(
      padding: EdgeInsets.only(top: 10),
      //width: _screenSize.width * 0.8,
      //height: _screenSize.height * 0.3,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          films[index].uniqueId = '${films[index].id}-target';
          return Hero(
            tag: films[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              //Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover)
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detailFilm',
                    arguments: films[index]),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(films[index].getPosterImg()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: films.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        itemWidth: _width,
        itemHeight: height,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
