import 'package:flutter/material.dart';

class taskScreen extends StatelessWidget {
  const taskScreen({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Metas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24, // Aumento do tamanho da fonte
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: Colors.black, size: 40),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Colors.black, size: 40,),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}