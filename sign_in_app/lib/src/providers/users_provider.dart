import 'dart:convert';
import 'package:http/http.dart' as http;

class UsersProvider {

  String _firebaseToken = 'AIzaSyDjxJ9zAII-QEPU4tdA1B7g9tI0HsCESQk';
  
  Future newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'return_secure_token': true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      // TODO: Save token on storage.
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'token': decodedResp['error']['message']};
    }
  }
}