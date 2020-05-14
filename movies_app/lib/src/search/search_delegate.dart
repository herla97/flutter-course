import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movies_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  String select = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Captian America',
  ];

  final lastMovie = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
      // Las acciones de nuestro AppBard
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del AppBar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que se muestran
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.indigoAccent,
          child: Text(select)
        ),
      );
    }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias cuando las personas escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalLanguage),
                onTap: () {
                  close(context, null);
                  movie.uniqueID = '';
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList(),
          );
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );

        }
      },
    );

  }

  //   @override
  //   Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias cuando las personas escribe

  //   final suggestedList = (query.isEmpty) 
  //                         ? lastMovie
  //                         : movies.where(
  //                           (m) => m.toLowerCase().startsWith(query)
  //                         ).toList();

  //   return ListView.builder(
  //     itemCount: suggestedList.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(suggestedList[i]),
  //         onTap: () {
  //           select = suggestedList[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }


  
}