import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_parte2/models/ninja_model.dart';

class Estadisticas extends ChangeNotifier {
  final String _urlBase = 'api.edamam.com';
  final String _apiKey = '7a87ced9c9ea2d9dcf4bf2a924615aa7';
  final String _app_id = '1210fd2a';

  List<Parsed> propiedadesAlimentos = [];

  Estadisticas() {
    getService();
  }
  getService() async {
    final url = Uri.https(_urlBase, '/api/food-database/v2/parser',{
      'app_id': _app_id,
      'app_key': _apiKey,
      'ingr': 'banana',
      'nutrition-type': 'cooking'
    });
    //final url = Uri.https(_urlBase, '/fdc/v1/foods/search', {'query': 'mango'});
    final respuesta = await http.get(url);
    final comida = Alimentos.fromJson(respuesta.body);
    propiedadesAlimentos =  comida.parsed!;
    notifyListeners();
    //print(propiedadesAlimentos[0].food!.label);
    //print(respuesta.body);
  }
}
