import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';

import 'package:qr_reader_app/src/pages/maps_page.dart';
import 'package:qr_reader_app/src/pages/address_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Reader'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _createFlotingActionButtom(),
    );
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0: return MapsPage();
      case 1: return AddressPage();

      default:
        return MapsPage();
    }
  }

  BottomNavigationBar _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Address')
        ),
      ],
    );
  }

  Widget _createFlotingActionButtom() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () => _scanQR(context),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  // Libreria con muchos problemas.
  _scanQR(BuildContext context) async {

    // https://www.littlewire.dev/
    // geo:40.67529934257727,-73.94276991328128

    //dynamic futureString = 'https://www.littlewire.dev/';
    dynamic futureString;

    
    try {
      futureString = await BarcodeScanner.scan();
    } catch(e) {
       print('error: ${e.toString()}');
    }
    print('Future string: ${futureString.rawContent}');

    if (futureString.rawContent != "") {
      final scan = ScanModel(value: futureString.rawContent);
      
      scansBloc.addScan(scan);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScan(context, scan);
        });
      } else {
        utils.openScan(context, scan);
      }
    }
  }

}
