import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:sign_in_app/src/blocs/validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Return stream data
  Stream<String> get emailStream    => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get fromValidStream => 
    Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insert stream data
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Get last value insert of the streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}