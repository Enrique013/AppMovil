import 'package:flutter/material.dart';
import 'branch_map_page.dart'; // Importamos la pantalla del mapa

void main() {
  // Punto de entrada principal de la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp envuelve toda la aplicación y define configuración general
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de "debug"
      home: const BranchMapPage(), // Pantalla inicial de la aplicación
    );
  }
}
