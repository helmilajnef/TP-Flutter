import 'package:flutter/material.dart';
import 'atelier1.dart';
import 'atelier2.dart';
import 'atelier3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material 3',
      theme: ThemeData(useMaterial3: true),
      // Replace ProductListPageM3 with a widget that exists in your imports
      home: const Atelier1(), // Assuming Atelier1 is your main page widget
    );
  }
}
