import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movies_app/src/models/movies_model.dart';

class MoviesProvider {
  String _apikey    = '776cfb4bd35beef0ca1ffcf7963f228f';
  String _url       = 'api.themoviedb.org';
  String _apiVersion = '3';
  String _language  = 'es-ES';

  Future<List<Movie>> getNowPlay() async{
    final url = Uri.https(_url, '$_apiVersion/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    //print(decodedData);

    final movies = new Movies.fromJsonList(decodedData['results']);

    // print(movies.items[1].title);
    
    return movies.items;

  }
}