import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {

  final titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtitleStyle = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _createImg(),
            _createTitle(),
            _createActions(),
            _createText(),
            _createText(),
            _createText(),
            _createText(),
            _createText(),
            _createText(),
            _createText(),
            _createText(),
          ],
        ),
      ),
    );
  }

  Widget _createImg() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage('https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
        height: 200.0,
        fit: BoxFit.cover
      ),
    );
  }

  Widget _createTitle() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lago Puente', style: titleStyle),
                  SizedBox(height: 7.0),
                  Text('bla bla bla blab bla bal', style: subtitleStyle)
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red, size: 30.0,),
            Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  Widget _createActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _action(Icons.call, 'Call'),
        _action(Icons.near_me, 'Route'),
        _action(Icons.share, 'Share'),
      ],
    );
  }

  Widget _action(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Icon(icon, color: Colors.blue, size: 40.0),
        SizedBox(height: 5.0),
        Text(text, style: TextStyle(fontSize: 15.0, color: Colors.blue)),
      ],
    );
  }

  Widget _createText() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        child: Text(
          'Dolor esse in minim esse anim in reprehenderit pariatur consequat anim tempor occaecat. Laborum cillum minim velit duis aliqua commodo officia laborum laborum tempor nostrud. Magna do nulla eu ipsum dolor consequat in esse ea. Quis qui anim duis elit in elit laborum ipsum do. Mollit mollit sit reprehenderit magna cupidatat anim. Mollit ea exercitation ea non deserunt.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
