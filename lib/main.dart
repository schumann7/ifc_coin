import 'package:flutter/material.dart';
import 'screens/primeira_tela.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IFC COIN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE5E5E5)),
      ),
      home: const TelaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}