import 'package:flutter/material.dart';

bool isNumeric(String s) {
   if(s.isEmpty) return false;

   final n = num.tryParse(s);

   return(n == null) ? false : true;
}

void showAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('¡Oops!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('¡ok!'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}