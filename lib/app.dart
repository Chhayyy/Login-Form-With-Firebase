import 'package:flutter/material.dart';
import 'screens/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        home: const Scaffold(
          body: FormPage(),
        ));
  }
}
