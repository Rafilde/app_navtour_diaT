import 'package:flutter/material.dart';
import 'dart:async';

import 'data/CameraPhotos.dart';
import 'data/Gallery_data.dart';

class Fotos extends StatefulWidget {
  const Fotos({super.key});

  @override
  State<Fotos> createState() => _FotosState();
}

class _FotosState extends State<Fotos> {
  TextEditingController newAlbumController = TextEditingController();

  final List<String> locates = <String>['Fortaleza', 'Sobral', 'Natal'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          elevation: 10,
          title: Text(
            "Galeria de fotos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: locates.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumDetails(name: locates[index]),
                  ),
                );
              },
              child: Gallery(name: locates[index]),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: createdNewAlbum,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void createdNewAlbum() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Criar novo álbum"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newAlbumController,
                decoration: InputDecoration(
                  labelText: 'Nome do álbum',
                  hintText: 'Digite o nome do álbum',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: create,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text("Criar"),
            ),
            TextButton(
              onPressed: cancel,
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void create() {
    setState(() {
      locates.add(newAlbumController.text);
      newAlbumController.clear();
    });
    Navigator.of(context, rootNavigator: true)
        .pop(); // Isso fecha o AlertDialog
  }

  void cancel() {
    setState(() {
      newAlbumController.clear();
    });
    Navigator.of(context, rootNavigator: true)
        .pop(); // Isso fecha o AlertDialog
  }
}
