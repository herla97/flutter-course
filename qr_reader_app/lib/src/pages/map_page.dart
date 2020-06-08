import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final map  = new MapController();

  List<String> mapTypes = ['streets-v11',
                          'dark-v10',
                          'light-v10',
                          'outdoors-v11',
                          'satellite-streets-v11',
                          'satellite-v9'];

  String mapSelect = 'streets-v11';
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 16.0);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createButtonFloat(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 16.0,
      ),
      layers: [
        _createMap(),
        _createMarker(scan)
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1Ijoic2FoZXJsYSIsImEiOiJja2I1eGFlazIxOGFhMnptdmUwY2o3cXdlIn0.duWvVxA8b5ViPpjfpCLMjg',
        'id': 'mapbox/$mapSelect'

        /* 
        maps types:

        streets-v11 
        outdoors-v11 
        light-v10 
        satellite-v9 
        satellite-streets-v11 
        dark-v10
        */
      }
    );
  }

  _createMarker(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 45.0,
              color: Colors.red,
            ),
          ),
        )
      ]
    );
  }

  Widget _createButtonFloat(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {
          if (count < mapTypes.length - 1) {
            count++;
            mapSelect = mapTypes[count];
          }else {
            count = 0;
            mapSelect = mapTypes[count];
          }
        });
      },
    );
  } 
}
