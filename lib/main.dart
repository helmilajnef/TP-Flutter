import 'package:flutter/material.dart';
import 'atelier1.dart'; 
import 'atelier2.dart'; 

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
      debugShowCheckedModeBanner: false, // <-- NOUVEAU: Supprime le bandeau DEBUG
      
      // DÉFINITION DES ROUTES
      initialRoute: '/profile', // Démarrage sur la page de profil
      routes: {
        '/profile': (context) => const ProfilePageM3(),
        '/products': (context) => const ProductListPageM3(),
      },
    );
  }
}