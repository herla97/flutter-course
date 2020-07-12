import 'package:flutter/material.dart';
import 'package:sign_in_app/src/blocs/provider.dart';
import 'package:sign_in_app/src/pages/home_page.dart';
import 'package:sign_in_app/src/pages/login_page.dart';
import 'package:sign_in_app/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APP',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'product': (BuildContext context) => ProductPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
