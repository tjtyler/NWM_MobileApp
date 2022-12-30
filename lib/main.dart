import 'package:flutter/material.dart';
import 'package:nwm_river_forecast/screens/test_login.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TestLogin(),
      ),
    );
  }
}
