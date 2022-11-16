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
            child: Text('Tigris River',
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
                Text('Max: 7132 cms',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                Text('Mean: 6734 cms',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18))
              ]),
            ),
          ]),
          _futureDayRow("Monday"),
          _futureDayRow("Tuesday"),
          _futureDayRow("Wednesday"),
          _futureDayRow("Thursday"),
          _futureDayRow("Friday"),
          _futureDayRow("Saturday"),
          _futureDayRow("Sunday"),
        ],
      )),
    );
  }

  Widget _futureDayRow(String day) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color.fromARGB(256, 256, 256, 256),
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Text(day + ": ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
          ],
        ));
  }
}
