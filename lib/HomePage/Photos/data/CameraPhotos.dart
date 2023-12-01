import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class AlbumDetails extends StatefulWidget {
  final String name;

  const AlbumDetails({Key? key, required this.name}) : super(key: key);

  @override
  State<AlbumDetails> createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Álbum"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Foto tira será salva no álbum: ${widget.name}"),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => openCamera(widget.name),
              icon: Icon(Icons.camera_alt),
              label: Text("Abrir Câmera"),
            ),
          ],
        ),
      ),
    );
  }

  Future openCamera(String name) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    await GallerySaver.saveImage(image.path, albumName: name);
  }
}
