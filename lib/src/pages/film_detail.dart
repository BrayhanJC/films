import 'package:films/src/models/Actors_models.dart';
import 'package:films/src/models/films_model.dart';
import 'package:films/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obteniendo datos que vienen en el navigator
    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(film),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            _posterTitle(film, context),
            _description(film),
            _actors(film),
          ]))
        ],
      ),
    );
  }

  Widget _createAppBar(Film film) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          film.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(film.getBackgroundImg()),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _posterTitle(Film film, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: film.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(film.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                film.title,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                film.originalTitle,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(film.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        film.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _actors(Film film) {
    final filmProvider = new FilmsProvider();

    return FutureBuilder(
      future: filmProvider.getActor(film.id.toString()),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> data) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
          pageSnapping: false,
          itemBuilder: (context, i) {
            return _actorCard(data[i]);
          },
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemCount: data.length),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(actor.getPhoto()),
                height: 150,
                fit: BoxFit.cover),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
