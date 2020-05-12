
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:movies_app/src/models/movies_model.dart';

class MoviesProvider {
  String _apikey    = '776cfb4bd35beef0ca1ffcf7963f228f';
  String _url       = 'api.themoviedb.org';
  String _apiVersion = '3';
  String _language  = 'es-ES';

  int _popularsPage = 0;

  bool _charge = false;

  List<Movie> _populars = new List();

  final _popularsStremController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStremController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStremController.stream;

  void disposeStreams() {
    _popularsStremController?.close();
  }

  Future<List<Movie>> _processingResp(Uri url) async{

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = new Movies.fromJsonList(decodedData['results']);
    
    return movies.items;
  }


  Future<List<Movie>> getNowPlay() async{
    final url = Uri.https(_url, '$_apiVersion/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language
    });

    return await _processingResp(url);
  }

  Future<List<Movie>> getPopular() async{

    if(_charge) return[];

    _charge = true;

    _popularsPage++;

    final url = Uri.https(_url, '$_apiVersion/movie/popular',{
      'api_key' : _apikey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final resp = await _processingResp(url);

    _populars.addAll(resp);
    popularsSink(_populars);

    _charge = false;

    return resp;
  }



}