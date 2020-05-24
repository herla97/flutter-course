import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class ButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backgroundApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titles(),
                _roundedButtons(),
              ],
            ),
          )
          
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _backgroundApp() {
    final gradient = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(53, 55, 98, 1.0),
            Color.fromRGBO(35, 37, 58, 1.0)
          ]
        )
      ),
    );

    final boxPink = Transform.rotate(
      angle: -pi / 4.5,
      child: Container(
        height: 365.0,
        width: 365.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(251, 76, 200, 1.0),
              Color.fromRGBO(253, 133, 175, 1.0),
            ]
          ),
        ),
      ),
    );
    
    
    return Stack(
      children: <Widget>[
        gradient,
        Positioned(
          top: -100.0,
          left: -50.0,
          child: boxPink
        )
      ],
    );
  }

  Widget _titles() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Classify Transaction', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Classify this transaction into a particular category', style: TextStyle(color: Colors.white, fontSize: 18.0))
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context)  {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme
          .copyWith(caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity, size: 30.0),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, size: 30.0),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.build, size: 30.0),
            title: Container()
          ),
        ],
      ),
    );
  }

  Widget _roundedButtons() {
    return Table(
      children: [
        TableRow(
          children: [
            _createRoundedButtons(Colors.blue, Icons.border_all, 'Panel'),
            _createRoundedButtons(Colors.purpleAccent, Icons.border_color, 'Edit'),
          ]
        ),
        TableRow(
          children: [
            _createRoundedButtons(Colors.blue, Icons.brightness_2, 'Moon'),
            _createRoundedButtons(Colors.purpleAccent, Icons.bubble_chart, 'Bubble'),
          ]
        ),
        TableRow(
          children: [
            _createRoundedButtons(Colors.blue, Icons.block, 'Secret'),
            _createRoundedButtons(Colors.purpleAccent, Icons.dashboard, 'Dashboard'),
          ]
        )
      ],
    );
  }

  Widget _createRoundedButtons(Color color, IconData icon, String text) {

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 0.0),
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(icon, color: Colors.white, size: 30.0),
              ),
              Text(text, style: TextStyle(color: color))
            ],
          ),
        ),
      ),
    );
  }
}