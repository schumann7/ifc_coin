import 'package:flutter/material.dart';
import '../particle_background.dart';

class TelaAlunoCriarConta extends StatelessWidget {
  const TelaAlunoCriarConta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta - Aluno'),
      ),
      body: Stack(
        children: [
          const ParticleBackground(),
          Center(
        child: Text('Tela de criação de conta para aluno'),
          ),
        ],
      ),
    );
  }
}