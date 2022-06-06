import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_parte2/services/food_services.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ninjaDataServices = Provider.of<Estadisticas>(context);
    
    if(ninjaDataServices.propiedadesAlimentos.isEmpty){
      return Container(
        color: Colors.purple.shade200,
        child: const Center(child: CircularProgressIndicator(color: Colors.purple,)),

      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Informacion De Alimentos"),
        ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Hola'),
              onTap:(){

              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
        
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Text('Nombre:'+ ninjaDataServices.propiedadesAlimentos[0].food!.label),
                  Text('Energia:'+ ninjaDataServices.propiedadesAlimentos[0].food!.nutrients.enercKcal.toString()+ "Kcal"),
                  Text('Fibra:'+ ninjaDataServices.propiedadesAlimentos[0].food!.nutrients.fibtg.toString() + "g"),
                  Text('Proteina:'+ ninjaDataServices.propiedadesAlimentos[0].food!.nutrients.procnt.toString() + "g"),
                  Text('Lipidos Totales:'+ ninjaDataServices.propiedadesAlimentos[0].food!.nutrients.fat.toString()+"g"),
              
                  
                ]),
              ),
              
          ),
          
        ],
      ),

      )
    );
  }
}
