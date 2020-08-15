import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({@required this.onSelectImage});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() => _storedImage = File(imageFile.path));
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName}');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage, fit: BoxFit.cover, width: double.infinity)
              : Container(child: Text('No image taken 😐'), alignment: Alignment.center),
        ),
        SizedBox(width: 10),
        Expanded(
            child: FlatButton.icon(
          icon: Icon(Icons.camera_alt),
          label: Text('Take a photo'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture,
        ))
      ],
    );
  }
}
