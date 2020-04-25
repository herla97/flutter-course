import 'package:flutter/material.dart';


// Ejemplo para explicar el uso de listas en flutter
class HomePageTemp extends StatelessWidget {

  final opcions = ['One', 'Two', 'Three', 'Four', 'Five'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components Temp'),
      ),
      body: ListView(
        // children: _createItems(),
        children: _createItemsShort(),
      ),
    );
  }

  // Forma larga usando for in
  // List<Widget> _createItems () {

  //   List<Widget> list = new List<Widget>();

  //   for (var opt in opcions) {
  //     final tempWidget = ListTile(
  //       title: Text(opt),
  //     );

  //     list..add(tempWidget)
  //       ..add(Divider(
  //         color: Colors.grey,
  //         height: 10.0,
  //         thickness: 5.0,
  //         indent: 30.0,
  //         endIndent: 30.0,
  //       ));
  //   }
    
  //   return list;
  // }

  // Forma chida usando map
  List<Widget> _createItemsShort (){

    return opcions.map((item){
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: Text('Testing'),
            leading: Icon(Icons.inbox),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
          )
        ],
      );
    }).toList();

  }


}