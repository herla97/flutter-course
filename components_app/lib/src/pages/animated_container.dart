import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.grey;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Container'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.slowMiddle,
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: _color
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: _changeShape,
      ),
    );
  }

  void _changeShape () {

    final radom = Random();

    setState(() {
      _width = radom.nextInt(300).toDouble();
      _height = radom.nextInt(300).toDouble();
      _color = Color.fromRGBO(
        radom.nextInt(255), 
        radom.nextInt(255), 
        radom.nextInt(255), 
        1);

      _borderRadius = BorderRadius.circular(radom.nextInt(300).toDouble());
      // _width = _height + 10;
      // _height = _width + 5;
      // _color = Colors.pink;

    });
  }
}