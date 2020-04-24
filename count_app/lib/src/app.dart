import 'package:flutter/material.dart';

// Buena practica agregar mis importaciones de antes de las predefinidas
// import 'package:count_app/src/pages/home_page.dart';
import 'package:count_app/src/pages/count_page.dart';

class MyApp extends StatelessWidget{
  
  @override
  Widget build(context) {
    return MaterialApp(
      home: Center(
        //child: HomePage(),
        child: CountPage(),
      ),
    );
  }
}