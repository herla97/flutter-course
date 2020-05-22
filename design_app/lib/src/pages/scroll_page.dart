import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _page1(),
          _page2(),
        ],
      ),
    );
  }

  Widget _page1() {
    return Stack(
      children: <Widget>[
        _backgroundColor(),
        _backgroundImage(),
        _text(),
      ],
    );
  }
  
  Widget _backgroundColor() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108,192,218,1.0),
    );
  }

  Widget _backgroundImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/original.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _text() {
    final textStyle = TextStyle(color: Colors.white, fontSize: 50.0);

    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text('11º', style: textStyle),
          Text('Miércoles', style: textStyle),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down, size: 80.0, color: Colors.white)
        ],
      ),
    );
  }

  Widget _page2() {
    return Stack(
      children: <Widget>[
        _backgroundColor(),
        _createButton(),
      ],
    );
  }

  Widget _createButton() {
    return Center(
      child: RaisedButton(
        elevation: 10.0,
        hoverColor: Colors.black87,
        shape: StadiumBorder(),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          child: Text('Bienvenido', style: TextStyle(fontSize: 20.0)),
        )
      ),
    );
  }



}