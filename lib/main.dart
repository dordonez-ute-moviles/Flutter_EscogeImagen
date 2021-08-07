import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*
OJO:
- pubspec.yaml
aumentar a 'dependencies:' -> 'image_picker:'
- android/app/src/main/AndroidManifest.xml
en emuladores Android 30 no se abren las cámaras. Aumentar <queries> en el AndroidManifest
 */

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Center(child:
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Row(children: [
                    Icon(Icons.camera),
                    Text('Toma foto...'),
                  ],),
                  onPressed: () {
                    getImageFromSource(context, ImageSource.camera);
                  }
              ),
              ElevatedButton(
                  child: Row(children: [
                    Icon(Icons.image_search),
                    Text('Selecciona foto...'),
                  ],),
                  onPressed: () {
                    getImageFromSource(context, ImageSource.gallery);
                  }
              ),
            ]
          ),
        ),
    );
  }

  void getImageFromSource(context, imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: imageSource,
    );
    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowPicture(pickedFile.path)),
      );
    }
  }

}

class ShowPicture extends StatelessWidget {
  ShowPicture(this.imgpath);

  final String imgpath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Esta es su foto...')),
      body: Container(
        child: Image.file(File(imgpath), fit: BoxFit.cover),
        width: MediaQuery.of(context).size.width,
      ),
      bottomNavigationBar: BottomAppBar(child: Text('${imgpath}')),
    );
  }
}
