import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valueSlider = 100.0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: Colors.grey,
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _createSlider(),
            // Divider(),
            Expanded(
              child: _createImage()
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSlider() {
    return Slider(
      activeColor: Colors.greenAccent,
      label: 'Tamaño de la imagen',
      // divisions: 20,
      value: _valueSlider,
      min: 10.0,
      max: 400.0,
      onChanged: (value) {
        setState(() {
          _valueSlider = value;
        });
      },
    );
  }

  Widget _createImage() {
    /* return Image(
        image: NetworkImage('https://hackpuntes.com/wp-content/uploads/2019/03/go.png'),
        width: _valueSlider,
        fit: BoxFit.contain,
      );
    */
    return FadeInImage(
      image: NetworkImage('https://hackpuntes.com/wp-content/uploads/2019/03/go.png'),
      placeholder: AssetImage('assets/original.gif'),
      fadeInDuration: Duration(milliseconds: 200),
      width: _valueSlider,
      fit: BoxFit.contain,
    );
  }
}