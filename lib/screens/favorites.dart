import 'package:flutter/material.dart';

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
    ));
  }
}
