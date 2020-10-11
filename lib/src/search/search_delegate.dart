import 'package:films/src/models/films_model.dart';
import 'package:films/src/providers/films_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculas = ['deadpool', 'cantiflas', 'iron man', 'Batman', 'Aquaman'];
  final peliculasRecientes = ['spiderman', 'Capitan America'];

  final filmsProvider = new FilmsProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones del appbar, icono para limpiar el texto por ejemplo
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print('pulsando');
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        print('leading icon');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que se van a mostrar
    return Center(
      child: Container(
        height: 100,
        width: 200,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // muestra los resultados de sugerencias al momento de buscar

    // final listaSugerida = (query.isEmpty)
    //                     ? peliculasRecientes
    //                     : peliculas.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, index){
    //       return ListTile(
    //         leading: Icon(Icons.movie),
    //         title: Text(listaSugerida[index]),
    //         onTap: (){
    //           seleccion = listaSugerida[index];
    //           showResults(context);
    //         },
    //       );
    //   },
    // );
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: filmsProvider.searchFilm(query),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          final films = snapshot.data;
          return ListView(
            children: films.map((element) {
              return ListTile(
                leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(element.getPosterImg()),
                    width: 50,
                    fit: BoxFit.cover),
                title: Text(element.title),
                subtitle: Text(element.originalTitle),
                onTap: (){

                  close(context, null);
                  element.uniqueId = '';
                  Navigator.pushNamed(context, 'detailFilm', arguments: element);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
