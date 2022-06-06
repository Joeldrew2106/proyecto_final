import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_parte2/models/ninja_model.dart';

class Estadisticas extends ChangeNotifier {
  final String _urlBase = 'api.edamam.com';
  final String _apiKey = '7a87ced9c9ea2d9dcf4bf2a924615aa7';
  final String _appId = '1210fd2a';
  List<String> listCompleter = [];
  Food? alimento;
  List<Parsed> propiedadesAlimentos = [];

  getFood(String foodName) async {
    try {
      final url = Uri.https(_urlBase, '/api/food-database/v2/parser', {
        'app_id': _appId,
        'app_key': _apiKey,
        'ingr': foodName,
        'nutrition': 'cooking'
      });
      final respuesta = await http.get(url);
      
      final parsed = Alimentos.fromJson(respuesta.body);

      alimento = parsed.parsed![0].food;
      //print(respuesta.body);
      notifyListeners();
    } catch (e) {
      //print(e);
    }
  }

  getComplete(String input) async {
    listCompleter.clear();
    final url = Uri.https(_urlBase, '/auto-complete',
        {'app_id': _appId, 'app_key': _apiKey, 'q': input, 'limit': '20'});
    final respuesta = await http.get(url);
    final decodeRespuesta = jsonDecode(respuesta.body);
    decodeRespuesta.forEach((v) => listCompleter.add(v.toString()));
    notifyListeners();
  }
}
