import 'package:films/src/providers/films_provider.dart';
import 'package:films/src/widgets/card_swiper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  FilmsProvider filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Películas en Cine'),
        backgroundColor: Colors.indigoAccent[100],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarget(),
            _footer(context),
                      ],
                    ),
                  ),
                );
              }
            
              Widget _swiperTarget() {
                
               
                return FutureBuilder(
                  future: filmsProvider.getInCinemas(),
                  //initialData: [],
                  builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                    print(snapshot);
                      if(snapshot.hasData){
                        return CardSwiper(films: snapshot.data);
                      }else{
                        return Container(
                          height: 400,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                  },
                );
            
              }
            
              Widget _footer(BuildContext context) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Text('Populares', style:Theme.of(context).textTheme.subtitle1),
                      // FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot){
                      //   return Container();
                      // })
                    ],
                  ),
                  
                );
              }
}

