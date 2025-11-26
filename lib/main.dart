import 'package:flutter/material.dart';
import 'atelier1.dart';
import 'atelier5.dart';
import 'atelier6.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = CartManager(); // instance globale du panier

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

          // Page d'accueil (tu peux changer pour ProfilePageM3 ou ProductListPageM3)
          home: ProductListPageM3(cartManager: cartManager),

          routes: {
            '/profile': (context) => ProfilePageM3(cartManager: cartManager),
            '/products':
                (context) => ProductListPageM3(cartManager: cartManager),
            '/atelier6': (context) => CartSummaryPage(cartManager: cartManager),
          },
        );
      },
    );
  }
}
