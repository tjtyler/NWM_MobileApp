import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List rivers = [];
  List filteredRivers = [];
  Icon _searchIcon = Icon(Icons.search);
  Icon _backArrow = Icon(Icons.arrow_back);
  Widget _appBarTitle = Text('River Forecast');
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.521563, -111.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(child: _googleMap(_center)),
    );
  }

  Widget _googleMap(center) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11.0,
      ),
      mapType: MapType.terrain,
    );
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _backArrow,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [IconButton(icon: _searchIcon, onPressed: _searchPressed)],
      backgroundColor: Color.fromARGB(255, 133, 85, 136),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: 'Search...',
            hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          style: TextStyle(
            color: Colors.white,
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('River Forecasts');
        filteredRivers = rivers;
        _filter.clear();
      }
    });
  }
}
