import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nwm_river_forecast/location_services.dart';
import 'search.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  final TextEditingController _searchController = TextEditingController();
  List rivers = [];
  List filteredRivers = [];
  final Icon _searchIcon = const Icon(Icons.search);
  final _backArrow = const Icon(Icons.arrow_back);
  final _appBarTitle = const Text('River Forecast');
  final Completer<GoogleMapController> _controller = Completer();

  final LatLng _center = const LatLng(40.2673, -111.6407);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildBar(context),
        body: Column(
          children: [_searchBar(), _googleMap(_center)],
        ));
  }

  Widget _googleMap(center) {
    return Expanded(
        child: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      mapType: MapType.terrain,
    ));
  }

  Widget _searchBar() {
    return Row(children: [
      Expanded(
        child: TextFormField(
          controller: _searchController,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'Search by City'),
          onChanged: (value) {
            print(value);
          },
        ),
      ),
      IconButton(
          onPressed: () async {
            var place =
                await LocationService().getPlace(_searchController.text);
            _goToPlace(place);
          },
          icon: _searchIcon)
    ]);
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
      backgroundColor: const Color.fromARGB(255, 133, 85, 136),
    );
  }

  void _searchPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 12),
    ));
  }
}
