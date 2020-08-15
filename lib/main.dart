import 'package:flutter/material.dart';
import 'package:great_places_flutter/screens/add_place_screen.dart';
import 'package:great_places_flutter/screens/places_list_screen.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Places App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          PlacesListScreen.routeName: (context) => PlacesListScreen(),
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
        },
      ),
    );
  }
}
