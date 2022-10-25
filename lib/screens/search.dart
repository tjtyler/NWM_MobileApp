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
  final dio = Dio();
  String _searchText = "";
  List rivers = [];
  List filteredRivers = [];
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('River Forecast');
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(41.521563, -111.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    this._getRivers();
    super.initState();
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
    );
  }

  PreferredSizeWidget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredRivers.length; i++) {
        if (filteredRivers[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredRivers[i]);
        }
      }
      filteredRivers = tempList;
    }
    return ListView.builder(
      itemCount: rivers == null ? 0 : filteredRivers.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredRivers[index]['name']),
          onTap: () => print(filteredRivers[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('River Forecasts');
        filteredRivers = rivers;
        _filter.clear();
      }
    });
  }

  void _getRivers() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = [];
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      rivers = tempList;
      rivers.shuffle();
      filteredRivers = rivers;
    });
  }
}
