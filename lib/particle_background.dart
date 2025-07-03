import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final int numberOfParticles = 50;
  final double maxDistance = 300;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(hours: 1))
          ..addListener(_updateParticles)
          ..forward();

    final random = Random();
    for (var i = 0; i < numberOfParticles; i++) {
      _particles.add(
        Particle(
          position: Offset(
            random.nextDouble() * window.physicalSize.width,
            random.nextDouble() * window.physicalSize.height,
          ),
          velocity: Offset(
            random.nextDouble() * 2 - 1,
            random.nextDouble() * 2 - 1,
          ),
        ),
      );
    }
  }

  void _updateParticles() {
    for (var p in _particles) {
      p.update();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEAF2FB), // tom claro azulado/cinza, similar ao da imagem
      child: CustomPaint(
        painter: ParticlePainter(particles: _particles, maxDistance: maxDistance),
        child: Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  Offset velocity;

  Particle({required this.position, required this.velocity});

  void update() {
    position += velocity;

    // Bounce on edges
    if (position.dx <= 0 || position.dx >= window.physicalSize.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy <= 0 || position.dy >= window.physicalSize.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double maxDistance;

  ParticlePainter({required this.particles, required this.maxDistance});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.indigo;

    for (var p in particles) {
      canvas.drawCircle(p.position / window.devicePixelRatio, 1, paint); // raio menor
    }

    for (var i = 0; i < particles.length; i++) {
      for (var j = i + 1; j < particles.length; j++) {
        final distance = (particles[i].position - particles[j].position).distance;
        if (distance < maxDistance) {
          final opacity = (1 - (distance / maxDistance)) * 0.3;
          final linePaint = Paint()
            ..color = Colors.indigo.withOpacity(opacity)
            ..strokeWidth = 1;
          canvas.drawLine(
            particles[i].position / window.devicePixelRatio,
            particles[j].position / window.devicePixelRatio,
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}