import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  InputPage({Key key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _name = '';
  String _email = '';
  String _password = '';

  String _date = '';
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inputs de texto')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _createInput(),
          Divider(),
          _createEmail(),
          Divider(),
          _createPassword(),
          Divider(),
          _createDate(context),
          Divider(),
          _createPerson(),
          Divider(),
        ],
      ),
    );
  }

  Widget _createInput() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('Letras ${_name.length}'),
          hintText: 'Nombre de la persona',
          labelText: 'Nombre',
          helperText: 'Solo el nombre',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _name = valor;
        });
        // print(_name);
      },
    );
  }

  Widget _createEmail() {
    return TextField(
        // autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            // counter: Text('Letras ${_name.length}'),
            hintText: 'Nombre de la persona',
            labelText: 'Email',
            // helperText: 'Solo el email',
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email)),
        onChanged: (valor) => setState(() => _email = valor)
        // print(_name);
        );
  }

  Widget _createPassword() {
    return TextField(
        // autofocus: true,
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            counter: Text('Letras ${_password.length}'),
            hintText: 'Password',
            labelText: 'Password',
            // helperText: 'Solo el email',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)
        ),
        onChanged: (valor) => setState(() => _password = valor)
        // print(_name);
        );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
        // autofocus: true,
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            counter: Text('Letras ${_password.length}'),
            hintText: 'Fecha de Nacimiento',
            labelText: 'Fecha de Nacimiento',
            // helperText: 'Solo el email',
            suffixIcon: Icon(Icons.calendar_view_day),
            icon: Icon(Icons.calendar_today)
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
        // print(_name);
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2025)
    );

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inputFieldDateController.text = _date;
      });
    }
  }

  Widget _createPerson() {
    return ListTile(
      title: Text('Nombre es: $_name'),
      subtitle: Text('Email es: $_email'),
    );
  }
}
