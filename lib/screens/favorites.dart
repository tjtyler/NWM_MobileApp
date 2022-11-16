import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// https://github.com/cmailoa/google_places_autocomplete/blob/master/main.dart
// https://medium.com/@ch.a.andremailoa/your-own-flutter-google-places-autocomplete-3e60c0358280

// https://www.youtube.com/watch?v=tfFByL7F-00&t=1106s

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _backArrow = const Icon(Icons.arrow_back);
  final _appBarTitle = const Text('Favorited Rivers');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: _appBarTitle,
        leading: IconButton(
          icon: _backArrow,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 133, 85, 136),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(30),
            child: Text('<River Name>',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30)),
          ),
          Stack(children: [
            Container(
                alignment: Alignment.center,
                child: Image.asset(
                    "/Users/travistyler/development/nwm_river_forecast/lib/resources/images/water.jpeg",
                    width: 200,
                    height: 200)),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              child: Column(children: const [
                Text('Max: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                Text('Mean: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18))
              ]),
            ),
          ])
        ],
      )),
    );
  }
}
