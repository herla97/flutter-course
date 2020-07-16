import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {

  static final UserPreferences instance = new UserPreferences._internal();

  factory UserPreferences() {
    return instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET of token.
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  

  // GET y SET of the last page.
  get lastPage {
    return _prefs.getString('lastPage') ?? 'login';
  }

  set lastPage( String value ) {
    _prefs.setString('lastPage', value);
  }

}

