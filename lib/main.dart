import 'package:flutter/material.dart';
import 'atelier1.dart'; // contient ProfilePageM3
import 'atelier4.dart'; // contient ProductListPageM3

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material 3',
      debugShowCheckedModeBanner: false,

      // ✅ Activation du Material 3
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),

      // ✅ Page de démarrage
      initialRoute: '/profile',

      // ✅ Routes disponibles dans ton app
      routes: {
        '/profile': (context) => const ProfilePageM3(),
        '/products': (context) => const ProductListPageM3(),
      },
    );
  }
}
