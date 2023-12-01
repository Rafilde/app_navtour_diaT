//import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/*void main() {
  runApp(FilterPage());
}*/

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            tooltip: 'Back',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Categorias',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: _buildCategoryTags(
                  'Entretenimento',
                  [
                    'park',
                    'casino',
                    'cinema',
                    'cafe',
                    'nightclub',
                    'bar',
                    'library',
                    'swingerclub',
                    'theatre',
                  ],
                  context,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      blurRadius: 2.0,
                      spreadRadius: 0,
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Espaço vertical entre categorias
              Container(
                child: _buildCategoryTags(
                  'Compras',
                  [
                    'cafe',
                    'fast_food',
                    'ice_cream',
                    'pub',
                    'restaurant',
                    'food_court',
                    'biergarten',
                  ],
                  context,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      blurRadius: 2.0,
                      spreadRadius: 0,
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0), // Espaço vertical entre categorias
              Container(
                child: _buildCategoryTags(
                  'Serviços',
                  [
                    'taxi',
                    'fuel',
                    'pharmacy',
                    'car_wash',
                    'bus_station',
                    'bicycle_rental',
                    'bicycle_parking',
                    'compressed_air',
                  ],
                  context,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(65, 0, 0, 0),
                      blurRadius: 2.0,
                      spreadRadius: 0,
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  
  Widget _buildCategoryTags(
      String categoryName, List<String> tags, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            categoryName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Wrap(
            spacing: 25.0,
            runSpacing: 25.0,
            children: tags.map((tag) {
              return InputChip(
                elevation: 2,
                shadowColor: Color.fromARGB(93, 0, 0, 0),
                label: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(tag);
                },
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ); 
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CustomInputChip extends  StatefulWidget {
  String filterName;
  List<bool> isSelec;

  CustomInputChip({
    Key? key,
    required this.isSelec,
    required this.filterName,
    required Widget label,
  }); 
          @override
         State<CustomInputChip> createState() => _CustomInputChipState();
}
class _CustomInputChipState extends State<CustomInputChip> {
  @override
  Widget build(BuildContext context) {
    return InputChip(
          key: widget.key,
          label: Text(widget.filterName),
           onPressed: () {
                  Navigator.of(context).pop(widget.filterName);
                },
          backgroundColor: widget.isSelec[0] ? Colors.amber : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
         // selected: widget.isSelec[0],
        );
  }
}