import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class Explorar extends StatefulWidget {
  const Explorar({super.key});

  @override
  State<Explorar> createState() => _ExplorarState();
}

class _ExplorarState extends State<Explorar> {
  String filtro = "";
  List<LatLng> routpoints = [LatLng(52.05884, -1.345583)];

  late final MapController mapController;
  late LocationData currentLozation;

  Set<Marker> markers = {};
  final Icon markerIcon = Icon(
    Icons.location_on_sharp,
    color: Colors.red,
    size: 48,
  );

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  void getCurrentLozation() async {
    var location = Location();

    currentLozation = await location.getLocation();

    setState(() {
      mapController.move(
          LatLng(currentLozation.latitude!, currentLozation.longitude!), 15.0);
    });
  }

  void addMarker(LatLng point) async {
    final marker = CustomMarker(point: point, icon: markerIcon);
    setState(() {
      markers.add(marker);
    });
  }

  final TextEditingController _controller = TextEditingController();
  String tagsQuery = " ";

  Future<void> fetchLocations() async {
    markers.clear();
    String name = _controller.text;

    if (name.isEmpty) name = "Fortaleza";

    http.Response nameResponse = await http.get(Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$name&format=json&polygon=1&addressdetails=1"));

    if (nameResponse.statusCode == 200) {
      final List<dynamic> data = json.decode(nameResponse.body);

      mapController.move(
          LatLng(double.parse(data[0]['lat']), double.parse(data[0]['lon'])),
          15.0);

      http.Response mapResponse = await http.get(Uri.parse(
          "http://overpass-api.de/api/interpreter?data=[out:json];(node(${data[0]['boundingbox'][0]},${data[0]['boundingbox'][2]},${data[0]['boundingbox'][1]},${data[0]['boundingbox'][3]})['amenity'~'^($tagsQuery)']['name'];);out 10;"));

      Map<String, dynamic> a = jsonDecode(mapResponse.body);

      List<dynamic> locations = a['elements'];

      for (dynamic locale in locations) {
        addMarker(LatLng(locale['lat'], locale['lon']));
      }
    } else {
      throw Exception('Falha ao carregar o Local');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(-3.751936, -38.58432),
                zoom: 11.0,
                onTap: (tapPosition, point) {},
              ),
              mapController: mapController,
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(markers: markers.toList()),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 15, left: 15, top: 25, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(30, 0, 0, 0),
                              offset: Offset(0, 0),
                              blurRadius: 6),
                        ]),
                    child: searchIcon(
                      text: tagsQuery,
                      controller: _controller,
                      onSearchPressed: fetchLocations,
                      onBackPressed: () async {
                        setState(() {
                          tagsQuery = " ";
                        });
                      },
                      
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, right: 15),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            offset: Offset(0, 0),
                            blurRadius: 6),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.light_mode_outlined,
                        color: Colors.blue,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, right: 15),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(30, 0, 0, 0),
                            offset: Offset(0, 0),
                            blurRadius: 6),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.cloud_queue,
                        color: Colors.blue,
                      ),
                      iconSize: 25,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: 40, // Altura do seu ListView
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    /*_filterTags("park"),
                    _filterTags("casino"),
                    _filterTags("cinema"),
                    _filterTags("nightclub"),
                    _filterTags("cafe"),
                    _filterTags("library"),*/
                    _moreFilter("Filtros"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moreFilter(String filterName) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: InputChip(
        elevation: 2,
        shadowColor: Color.fromARGB(93, 0, 0, 0),
        label: Text(
          filterName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () async {
          final tagSelecionada = await Navigator.pushNamed(context, '/filtros');
          if (tagSelecionada != null) {
            setState(() {
              tagsQuery = "$tagSelecionada";
            });
            fetchLocations();
          }
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget _filterTags(String filterName) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10, left: 15),
        child: CustomInputChip(
          filterName: filterName,
          isSelec: List.filled(1, false),
          label: Text(filterName),
        ));
  }
}

class CustomInputChip extends StatefulWidget {
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
        setState(() {
          widget.isSelec[0] = !widget.isSelec[0];
        });
      },
      backgroundColor: widget.isSelec[0] ? Colors.amber : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // selected: widget.isSelec[0],
    );
  }
}

class searchIcon extends StatefulWidget {
  String text;
  final TextEditingController? controller;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onBackPressed;

  searchIcon(
      {super.key,
      required this.text,
      this.controller,
      this.onSearchPressed,
      this.onBackPressed,});

  @override
  State<searchIcon> createState() => _searchIconState();
}

class _searchIconState extends State<searchIcon> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        prefixIcon: IconButton(
          icon:
              widget.text != " " ? Icon(Icons.arrow_back) : Icon(Icons.search),
          color: Color.fromARGB(255, 116, 116, 116),
          onPressed: () async {
            if (widget.text == " " && widget.onSearchPressed != null) {
              widget.onSearchPressed!();
            } else {
              setState(() {
                widget.text = " ";
              });
            }
            if (widget.text == " " && widget.onBackPressed != null) {
              widget.onBackPressed!();
              widget.onSearchPressed!();
            }
           
          },
        ),
        border: InputBorder.none,
        hintText: "Pesquisar",
        hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
      ),
    );
  }
}

class CustomMarker extends Marker {
  CustomMarker({
    required LatLng point,
    required Icon icon,
    String? width,
    String? height,
    AnchorPos? anchorPos,
    bool rotate = false,
  }) : super(
          point: point,
          builder: (BuildContext context) {
            return Icon(
              icon.icon,
              color: icon.color,
              size: icon.size,
            );
          },
          anchorPos: anchorPos,
          rotate: rotate,
        );
}



/*TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Color.fromARGB(255, 116, 116, 116),
                          onPressed: () {
                            fetchLocations();
                          },
                        ),
                        border: InputBorder.none,
                        hintText: "Pesquisar",
                        hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                      ),
                    ),*/