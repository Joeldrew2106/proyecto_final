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
  final controllerGramos = TextEditingController();
  double gramos = 50;
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
          setState(() {
            gramos = 50;
          });
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          const FloatingSearchBarAction(
              showIfOpened: false, child: Icon(Icons.search)),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
                          setState(() {
                            gramos = 50;
                          });
                        },
                        child: Container(
                          color: const Color.fromARGB(255, 192, 214, 223),
                          padding: const EdgeInsets.all(10),
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
      return ninjaDataServices.alimento == null
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: const Color.fromARGB(255, 234, 234, 234),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 234, 234, 234),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: Image.network(
                                  ninjaDataServices.alimento!.image)),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                ninjaDataServices.alimento!.label,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${ninjaDataServices.alimento!.nutrients.enercKcal! * gramos / 100}'),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.whatshot,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                  const Text('Calorías'),
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            const Icon(
                              Icons.fastfood_outlined,
                              color: Colors.orange,
                            ),
                            Text(
                                '${ninjaDataServices.alimento!.nutrients.fat! * gramos / 100}'),
                            const Text('Grasas')
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Icon(
                              Icons.battery_charging_full_sharp,
                              color: Colors.yellow.shade600,
                            ),
                            Text(
                                '${ninjaDataServices.alimento!.nutrients.procnt! * gramos / 100}'),
                            const Text('Proteína')
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Icon(
                              Icons.breakfast_dining,
                              color: Colors.brown.shade400,
                            ),
                            Text(
                                '${ninjaDataServices.alimento!.nutrients.chocdf! * gramos / 100}'),
                            const Text('Carbohidratos')
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        const Text('Gramos:'),
                        Slider(
                          min: 50,
                          value: gramos,
                          max: 2000,
                          divisions: 1950,
                          label: gramos.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              gramos = value;
                            });
                          },
                        ),
                      ],
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
          buildCardFood(),
          buildFloatingSearchBar(),
        ],
      ),
    );
  }
}
