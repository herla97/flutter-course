import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  final textS = new TextStyle(fontSize: 30.0);

  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de Taps:', style: textS),
            Text('$count', style: textS),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          // count = count + 1;
          print('hola mundo');
        },
      ),
    );
  }
}