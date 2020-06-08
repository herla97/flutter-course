import 'dart:async';

import 'package:qr_reader_app/src/bloc/validator.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._();
  
  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._() {
    // Obtener Scans de la base de datos
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(geoValidation);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(httpValidation);

  dispose() {
    _scansController?.close();
  }


  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }

  deleteScanByID(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }
  
}