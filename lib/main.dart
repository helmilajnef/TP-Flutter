import 'package:flutter/material.dart';
import 'atelier1.dart';
import 'atelier5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = CartManager(); // instance globale

    return AnimatedBuilder(
      animation: cartManager,
      builder: (context, child) {
        return MaterialApp(
          title: 'Ateliers Flutter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.deepPurple,
          ),
          home: ProfilePageM3(cartManager: cartManager),
          routes: {
            '/profile': (context) => ProfilePageM3(cartManager: cartManager),
            '/products':
                (context) => ProductListPageM3(cartManager: cartManager),
          },
        );
      },
    );
  }
}
