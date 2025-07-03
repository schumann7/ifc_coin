import 'package:flutter/material.dart';
import 'tela_aluno_criar_conta.dart';
import 'tela_professor_criar_conta.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IFC COIN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bem-vindo ao IFC COIN!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação do botão
              },
              child: const Text('Começar'),
            ),
          ],
        ),
      ),
    );
  }
}