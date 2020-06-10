import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_prefs/user_preferences.dart';
import 'package:user_preferences/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _secondaryColor;
  int _gender;

  TextEditingController _textController;

  final prefs = new UserPreferences();

  @override
  void initState() {
    
    super.initState();

    prefs.lastPage = SettingsPage.routeName;

    _gender = prefs.gender;
    _secondaryColor = prefs.secondaryColor;

    _textController = new TextEditingController( text: prefs.userName);
  }

   _setSelectedRadio(int value){
    prefs.gender = value;

    setState(() {
      _gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: (prefs.secondaryColor) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold))
          ),
          Divider(),
          SwitchListTile(
            title: Text('Secondary Color'),
            value: _secondaryColor,
            onChanged: (value) {
              setState(() {
                _secondaryColor = value;
                prefs.secondaryColor = value;
              });
            },
          ),
          RadioListTile(
            title: Text('Male'),
            value: 1,
            groupValue: _gender,
            onChanged: _setSelectedRadio,
          ),
          RadioListTile(
            title: Text('Female'),
            value: 2,
            groupValue: _gender,
            onChanged: _setSelectedRadio,
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Name',
                helperText: 'Person name using phone',
              ),
              onChanged: (value) {
                prefs.userName = value;
              },
            )
          )
        ],
      ),
    );
  }
}