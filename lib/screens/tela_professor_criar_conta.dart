import 'package:flutter/material.dart';
import '../particle_background.dart';

class TelaProfessorCriarConta extends StatelessWidget {
  const TelaProfessorCriarConta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta - Professor'),
      ),
      body: Stack(
        children: [
          const ParticleBackground(),
          Center(
        child: Text('Tela de criação de conta para professor'),
          ),
        ],
      ),
    );
  }
}