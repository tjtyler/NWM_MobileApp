import 'package:nwm_river_forecast/place_autocomplete.dart';
import 'package:nwm_river_forecast/repositories/places/base_places_repositories.dart';
import '../../place_autocomplete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesRepository extends BasePlacesRepository {
  final String key = 'AIzaSyAZbG9wTZbKpju3qk-rid9JlusNkfO2L2M';
  final String types = 'geocode';

  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['prediction'] as List;

    return results.map((place) => PlaceAutocomplete.fromJson(place)).toList();
  }
}
