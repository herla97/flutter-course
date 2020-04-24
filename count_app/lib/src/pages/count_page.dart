import 'package:flutter/material.dart';

class CountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CountPageState();
}

// El guíon bajo hace privada esa clase o variable y solo se puede utilizar aqui.
class _CountPageState extends State<CountPage> {
  final _textS = new TextStyle(fontSize: 30.0);

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Page'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de Taps:', style: _textS),
            Text('$_count', style: _textS),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createButtons(),
    );
  }

  Widget _createButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: _reset),
        Expanded(child: SizedBox()),
        FloatingActionButton(child: Icon(Icons.remove_circle_outline), onPressed: _subtract),
        SizedBox(width: 10.0),
        FloatingActionButton(child: Icon(Icons.add_circle_outline), onPressed: _add)
      ],
    );
  }

  void _add() {
    setState(() => _count++);
  }
  
  void _subtract() {
    setState(() => _count--);
  }

  void _reset() {
    setState(() => _count = 0);
  }

}
