import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _intance = new UserPreferences._internal();

  factory UserPreferences() {
    return _intance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    // Es igual no es necesario
    // this._prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
  }

  // Ninguna de estas propiedades se usa
  // bool _secondaryColor;
  // int _gender;
  // String _name;

  // GET y SET del Genero
  get gender {
    return _prefs.getInt('gender') ?? 1;
  }

  set gender(int value) {
    _prefs.setInt('gender', value);
  }

  // GET y SET del Color Secundario
  get secondaryColor {
    return _prefs.getBool('secondaryColor') ?? false;
  }

  set secondaryColor(bool value) {
    _prefs.setBool('secondaryColor', value);
  }

  // GET y SET del Nombre de Usuario
  get userName {
    return _prefs.getString('userName') ?? '';
  }

  set userName(String value) {
    _prefs.setString('userName', value);
  }

    // GET y SET de la ultima pagina
  get lastPage {
    return _prefs.getString('lastPage') ?? 'home';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }


}