import 'package:flutter/material.dart';
import 'package:sign_in_app/src/blocs/login_bloc.dart';
export 'package:sign_in_app/src/blocs/login_bloc.dart';

import 'package:sign_in_app/src/blocs/products_bloc.dart';
export 'package:sign_in_app/src/blocs/products_bloc.dart';

class Provider extends InheritedWidget {
  final _loginBloc = LoginBloc();
  final _productsBloc = ProductsBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static ProductsBloc productsBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
}
