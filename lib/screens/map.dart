import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nwm_river_forecast/location_services.dart';
import 'package:nwm_river_forecast/screens/favorites.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// https://github.com/cmailoa/google_places_autocomplete/blob/master/main.dart
// https://medium.com/@ch.a.andremailoa/your-own-flutter-google-places-autocomplete-3e60c0358280

// https://www.youtube.com/watch?v=tfFByL7F-00&t=1106s

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({super.key});

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  var _searchController = TextEditingController();
  var uuid = new Uuid();
  var _showSuggestions = false;
  late String _sessionToken;
  List<dynamic> _placeList = [];

  List rivers = [];
  List filteredRivers = [];
  final Icon _searchIcon = const Icon(Icons.search);
  final _backArrow = const Icon(Icons.arrow_back);
  final Icon menuIcon = Icon(Icons.menu);
  final _appBarTitle = const Text('River Search');
  final Completer<GoogleMapController> _controller = Completer();

  final LatLng _center = const LatLng(40.2673, -111.6407);

  @override
  void initState() {
    super.initState();
    // _searchController.addListener(() {
    //   _onChanged();
    // });
  }

  Future<void> getSuggestion(String input) async {
    setState(() {
      _sessionToken ??= uuid.v4();
    });
    String kPLACES_API_KEY = "AIzaSyCqEP3AT-g_PHsDbLjfYeNca64JAUNbm3Y";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _searchBar(),
            _placeListView(context),
            _googleMap(_center)
          ],
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
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: _searchController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(hintText: 'Search by City'),
            onChanged: (value) async {
              getSuggestion(_searchController.text);
              setState(() {
                if (_searchController.text == "") {
                  _showSuggestions = false;
                } else {
                  _showSuggestions = true;
                }
              });
            },
            onFieldSubmitted: (value) async {
              setState(() {
                _showSuggestions = false;
                _sessionToken = uuid.v4();
              });
              _goToPlace(await LocationService().getPlace(value));
            },
            onTap: () => {
              setState(() {
                _sessionToken = uuid.v4();
              })
            },
          ),
        )),
        IconButton(
            onPressed: () async {
              setState(() {
                _showSuggestions = false;
              });
              var place =
                  await LocationService().getPlace(_searchController.text);
              _goToPlace(place);
            },
            icon: _searchIcon)
      ],
    );
  }

  Visibility _placeListView(BuildContext context) {
    return Visibility(
      visible: _showSuggestions,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _placeList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_placeList[index]["description"]),
            onTap: () =>
                {_searchController.text = _placeList[index]["description"]},
          );
        },
      ),
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
      backgroundColor: const Color.fromARGB(255, 133, 85, 136),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritesScreen()));
            },
            icon: menuIcon),
      ],
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
