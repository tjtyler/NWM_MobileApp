import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _backArrow = const Icon(Icons.arrow_back);
  Widget _appBarTitle = const Text('River Forecast');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildBar(context),
        body: // Container(child: _googleMap(_center)),
            Text("Search Screen"));
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
    );
  }
}
