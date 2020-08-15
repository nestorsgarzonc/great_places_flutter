import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_flutter/helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get getItems => [..._items];

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: pickedImage,
      location: null,
      title: title,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (x) => Place(
            id: x['id'],
            title: x['title'],
            image: File(x['image']),
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
