import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'search.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  final TextEditingController _filter = TextEditingController();
  List rivers = [];
  List filteredRivers = [];
  Icon _searchIcon = const Icon(Icons.search);
  final _backArrow = const Icon(Icons.arrow_back);
  Widget _appBarTitle = const Text('River Forecast');
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(40.2673, -111.6407);

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
      backgroundColor: const Color.fromARGB(255, 133, 85, 136),
    );
  }

  void _searchPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }
  // setState(() {
  //   if (_searchIcon.icon == Icons.search) {
  //     _searchIcon = const Icon(Icons.close);
  //     _appBarTitle = TextField(
  //       controller: _filter,
  //       decoration: const InputDecoration(
  //         prefixIcon: Icon(Icons.search, color: Colors.white),
  //         hintText: 'Search...',
  //         hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
  //       ),
  //       style: const TextStyle(
  //         color: Colors.white,
  //       ),
  //     );
  //   } else {
  //     _searchIcon = const Icon(Icons.search);
  //     _appBarTitle = const Text('River Forecasts');
  //     filteredRivers = rivers;
  //     _filter.clear();
  //   }
  // });
  // }
}
