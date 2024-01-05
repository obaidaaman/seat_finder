import 'package:flutter/material.dart';

import 'package:seat_finder/ui_components/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Seat Finder',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
