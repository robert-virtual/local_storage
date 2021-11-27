import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:local_storage/models/recarga.dart';

class _RecargasProvider {
  List<dynamic> recargas = [];
  _RecargasProvider() {
    cargarData();
  }
  // Map<String, List<Map<String,dynamic>>>
  Future<Map<String, List<Recarga>>> cargarData() async {
    final data = await rootBundle.loadString('data/data.json');
    Map<String, List<dynamic>> json = Map.from(jsonDecode(data));
    Map<String, List<Recarga>> listaElementos = {};
    json.forEach((key, value) {
      print("$key, ${value[0]}");
      listaElementos[key] = List.generate(value.length, (i) => Recarga.fromJson(value[i]));
    });
    return listaElementos;
  }
}

final recargasProvider = _RecargasProvider();
