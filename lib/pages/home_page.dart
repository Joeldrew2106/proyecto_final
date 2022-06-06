import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_parte2/services/food_services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final floatingController = FloatingSearchBarController();
  @override
  Widget build(BuildContext context) {
    final ninjaDataServices = Provider.of<Estadisticas>(context);

    Widget buildFloatingSearchBar() {
      final isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait;

      return FloatingSearchBar(
        controller: floatingController,
        initiallyHidden: false,
        hint: 'Buscar alimento',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onSubmitted: (value) {
          ninjaDataServices.getComplete(value);
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
              showIfOpened: false, child: const Icon(Icons.search)),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ninjaDataServices.listCompleter.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          ninjaDataServices
                              .getFood(ninjaDataServices.listCompleter[index]);
                          floatingController.close();
                        },
                        child: Container(
                          color: Color.fromARGB(255, 192, 214, 223),
                          padding: EdgeInsets.all(10),
                          height: 50,
                          child: Text(ninjaDataServices.listCompleter[index]),
                        ),
                      );
                    }))),
          );
        },
      );
    }

    Widget buildCardFood() {
      return ninjaDataServices.responseFood == null
          ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromARGB(255, 234, 234, 234),


          )
          : Container(
              
              color: Color.fromARGB(255, 234, 234, 234),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),

                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.network(ninjaDataServices.responseFood!.image)
                            ),
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(ninjaDataServices.responseFood!.label),
                              Row( 
                                mainAxisAlignment: MainAxisAlignment.center, 
                                children: [
                                Text('${ninjaDataServices.responseFood!.nutrients.enercKcal}'),
                                Icon(Icons.access_alarms)

                              ],
                              ),
                              Text('Kilo Calorias')

                            ],
                          ))
                        ],
                      ),

                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(child: Column(
                            children: [
                               Icon(Icons.access_alarms),
                               

                            ],
                          ))
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
           Align ( alignment: Alignment.center, child: buildCardFood()),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }
}
