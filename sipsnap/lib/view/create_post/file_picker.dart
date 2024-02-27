import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FilePicker extends StatefulWidget {
  final void Function(String) _setImageUrl;
  final void Function(String) _setUrl;
  FilePicker(this._setImageUrl, this._setUrl, {super.key});

  @override
  _FilePickerState createState() {
    return _FilePickerState();
  }
}

class _FilePickerState extends State<FilePicker> {
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
          widget._setUrl(image.path);
      // reference to the firebase storage
      Reference ref = FirebaseStorage.instance.ref().child('images');

      // reference to the image file
      //make unique image name
      String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference file = ref.child(uniqueName);

      // uploading the image
      await file.putFile(File(image.path));

      // getting the image url
      imageUrl = await file.getDownloadURL();
      widget._setImageUrl(imageUrl);
      print(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () async {
            await _getImage(ImageSource.camera);
            // this is the image url store it in the community post or recipe post
            print(imageUrl);

          },
          icon: const Icon(Icons.camera_alt, color: Colors.black, size: 35),
        ),
        IconButton(
          onPressed: () async{
            await _getImage(ImageSource.gallery);
            // this is the image url store it in the community post or recipe post
            print(imageUrl);
          },
          icon: const Icon(Icons.photo, color: Colors.black, size: 35),
        ),
      ],
      ),
    ],
    );
  }
}