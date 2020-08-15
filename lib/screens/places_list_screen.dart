import 'package:flutter/material.dart';
import 'package:great_places_flutter/providers/great_places.dart';
import 'package:great_places_flutter/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = 'PlacesListScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (context, places, child) => places.getItems.length <= 0
                    ? child
                    : ListView.builder(
                        itemCount: places.getItems.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                              backgroundImage: FileImage(places.getItems[index].image)),
                          title: Text(places.getItems[index].title),
                        ),
                      ),
                child: Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
