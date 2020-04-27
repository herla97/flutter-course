import 'package:flutter/material.dart';
import 'package:components_app/src/providers/menu_provider.dart';
import 'package:components_app/src/utils/icon_string_util.dart';
// import 'package:components_app/src/pages/alert_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components')
      ),
      body: _list(),
    );
  }

  Widget _list() {
    
   /*  Esta forma no es la recomendada por que nuestra
    App se veria como congelada por eso se usa 
    un future Builder. 
    Este ejemplo solo es educativo :v
    */

    //print(menuProvider.opcions);
    // menuProvider.chargeData()
    // .then((opcions) {
    //   print('list');
    //   print(opcions);
    // });


    // return ListView(
    //   children: _listItems(),
    // );

    return FutureBuilder(
      future: menuProvider.chargeData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

        // print('builder');
        // print(snapshot.data);
        return ListView(
          children: _listItems(snapshot.data, context),
        );
      },
    );

  }

  List<Widget> _listItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opcions = [];

    data.forEach((opt){
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);
          // final route = MaterialPageRoute(
          //   builder: (context) => AlertPage()
          // );
          // Navigator.push(context, route);
        },
      );

      opcions..add(widgetTemp)
        ..add(Divider());

    });

    return opcions;

  }
}