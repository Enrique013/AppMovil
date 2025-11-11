import 'package:flutter/material.dart';
import 'package:dio_app/home_page.dart'; // ✅ importa tu HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // opcional: quita el banner de debug
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // ✅ activa Material 3 si tu versión lo soporta
      ),
      home: const HomePage(),
    );
  }
}
