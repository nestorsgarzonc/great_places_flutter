import 'dart:io';
import 'package:flutter/material.dart';
import 'package:great_places_flutter/providers/great_places.dart';
import 'package:provider/provider.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'AddPlaceScreen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a new place')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                  ],
                ),
              ),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.add),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              label: Text('Add place'),
              elevation: 0,
              color: Theme.of(context).accentColor,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onPressed: _savePlace,
            ),
          ],
        ),
      ),
    );
  }
}
