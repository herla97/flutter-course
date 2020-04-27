import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MenuProvider {
  List <dynamic> opcions = [];

  _MenuProvider(){
    chargeData();
  }

  Future<List<dynamic>> chargeData() async {

    final resp = await rootBundle.loadString('data/menu_opts.json');


    Map dataMap = json.decode(resp);
    // print(dataMap['rutas']);
    opcions = dataMap['rutas'];

    return opcions;
  }
}

final menuProvider = new _MenuProvider();