import 'package:app_navtour/HomePage/Photos/Fotos.dart';
import 'package:flutter/material.dart';
import 'MapPage/Explorar.dart';
import 'Favoritos.dart';
import 'Roteiro.dart';
import 'MapPage/Filtros.dart';

/*void main() {
  runApp(HomePage());
}*/
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<IconData> unselectIcon = [
    Icons.location_on_outlined,
    Icons.favorite_border,
    Icons.image_outlined,
    Icons.map_outlined
  ];
  List<IconData> selectIcon = [
    Icons.location_on,
    Icons.favorite,
    Icons.image,
    Icons.map
  ];

  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(_selectedIndex == 0 ? selectIcon[0] : unselectIcon[0]),
        label: "Explorar",
      ),
      BottomNavigationBarItem(
        icon: Icon(_selectedIndex == 1 ? selectIcon[1] : unselectIcon[1]),
        label: 'Favoritos',
      ),
      BottomNavigationBarItem(
        icon: Icon(_selectedIndex == 2 ? selectIcon[2] : unselectIcon[2]),
        label: 'Fotos',
      ),
      BottomNavigationBarItem(
        icon: Icon(_selectedIndex == 3 ? selectIcon[3] : unselectIcon[3]),
        label: 'Roteiro',
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List Pages = [
    Explorar(), 
    Favoritos(), 
    Fotos(), 
    Roteiro(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      '/filtros': (context) => FilterPage(), // Rota para a página "filtros"
    },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavigationBarItems(),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 7, 143, 255),
          unselectedFontSize: 15,
          selectedFontSize: 15,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}