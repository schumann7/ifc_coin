import 'package:flutter/material.dart';
import 'como_ganhar.dart';
import 'faq.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.home, color: Colors.black),
        title: const Text(
          'Início',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF42A5DA),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Seu saldo atual:',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(221, 243, 243, 243)),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '30 IFC Coin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color.fromARGB(255, 253, 254, 255),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Corresponde a 40 horas',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(221, 243, 243, 243)),
                  ),
                ],
              ),
            ),

            
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 40),
              child: Image.asset(
                'assets/ifc_coin_logo.png',
                fit: BoxFit.cover,
              ),
            ),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.2,
              children: [
                _HomeCard(
                  icon: Icons.receipt_long,
                  iconColor: Color(0xFFE53935),
                  title: 'Histórico de Transações',
                  textColor: Color(0xFFE53935),
                  onTap: () {},
                ),
                _HomeCard(
                  icon: Icons.attach_money,
                  iconColor: Color(0xFF388E3C),
                  title: 'Como Ganhar Coins',
                  textColor: Color(0xFF388E3C),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComoGanharScreen(),
                      ),
                    );
                  },
                ),
                _HomeCard(
                  icon: Icons.check_circle_outline,
                  iconColor: Color(0xFF1976D2),
                  title: 'Metas',
                  textColor: Color(0xFF1976D2),
                  onTap: () {},
                ),
                _HomeCard(
                  icon: Icons.question_answer,
                  iconColor: Color(0xFFFFA000),
                  title: 'FAQ',
                  textColor: Color(0xFFFFA000),
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const FAQScreen(),
                    ),
                  );
                  },
                ),
              ],
            ),
            const SizedBox(height: 100),
            const Text(
              'IFC Coin: Sua moeda digital\npor horas de dedicação na instituição.',
              style: TextStyle(fontSize: 20, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color textColor;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.textColor,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 36),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
