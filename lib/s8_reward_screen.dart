import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Flutter Widget mô phỏng màn hình: REWARD
/// Ngôi sao có hiệu ứng: pulse, xoay, pháo hoa confetti, sparkle xung quanh

class S8rewardScreen extends StatefulWidget {
  const S8rewardScreen({super.key});

  @override
  State<S8rewardScreen> createState() => _S8rewardScreenState();
}

class _S8rewardScreenState extends State<S8rewardScreen>
    with TickerProviderStateMixin {
  // Pulse + scale bounce khi vào màn
  late AnimationController _bounceCtrl;
  late Animation<double> _bounceAnim;

  // Xoay nhẹ liên tục
  late AnimationController _rotateCtrl;
  late Animation<double> _rotateAnim;

  // Pulse glow ring
  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  // Confetti
  late AnimationController _confettiCtrl;

  // Sparkle tia sáng xung quanh
  late AnimationController _sparkleCtrl;
  late Animation<double> _sparkleAnim;

  final List<_ConfettiParticle> _particles = [];
  final math.Random _rng = math.Random();

  @override
  void initState() {
    super.initState();

    // ── Bounce vào
    _bounceCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _bounceAnim = CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticOut);
    _bounceCtrl.forward();

    // ── Xoay nhẹ
    _rotateCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
    _rotateAnim = Tween<double>(begin: -0.06, end: 0.06).animate(
        CurvedAnimation(parent: _rotateCtrl, curve: Curves.easeInOut));

    // ── Glow pulse
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
      ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // ── Confetti
    _confettiCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
    _generateParticles();

    // ── Sparkle
    _sparkleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _sparkleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(parent: _sparkleCtrl, curve: Curves.easeInOut));
  }

  void _generateParticles() {
    _particles.clear();
    final colors = [
      const Color(0xFFFBBF24),
      const Color(0xFF34D399),
      const Color(0xFF60A5FA),
      const Color(0xFFF472B6),
      const Color(0xFFA78BFA),
      const Color(0xFFFB7185),
    ];
    for (int i = 0; i < 30; i++) {
      _particles.add(_ConfettiParticle(
        x: _rng.nextDouble(),
        delay: _rng.nextDouble(),
        size: 5 + _rng.nextDouble() * 7,
        color: colors[_rng.nextInt(colors.length)],
        speed: 0.4 + _rng.nextDouble() * 0.6,
        drift: (_rng.nextDouble() - 0.5) * 0.3,
        shape: _rng.nextInt(3),
      ));
    }
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    _rotateCtrl.dispose();
    _glowCtrl.dispose();
    _confettiCtrl.dispose();
    _sparkleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Confetti layer
            AnimatedBuilder(
              animation: _confettiCtrl,
              builder: (_, __) => CustomPaint(
                painter: _ConfettiPainter(
                    particles: _particles, progress: _confettiCtrl.value),
                child: const SizedBox.expand(),
              ),
            ),

            // ── Main content
            Padding(
              padding: EdgeInsets.all(isTablet ? 32.0 : 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      // ── Star với hiệu ứng
                      ScaleTransition(
                        scale: _bounceAnim,
                        child: AnimatedBuilder(
                          animation: Listenable.merge(
                              [_rotateAnim, _glowAnim, _sparkleAnim]),
                          builder: (_, __) {
                            return SizedBox(
                              width: isTablet ? 200 : 170,
                              height: isTablet ? 200 : 170,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer glow ring 2
                                  Transform.scale(
                                    scale: _glowAnim.value * 1.1 + 0.3,
                                    child: Container(
                                      width: isTablet ? 150 : 130,
                                      height: isTablet ? 150 : 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFFFDE047)
                                            .withOpacity(0.12 * _glowAnim.value),
                                      ),
                                    ),
                                  ),
                                  // Outer glow ring 1
                                  Transform.scale(
                                    scale: _glowAnim.value * 0.9 + 0.2,
                                    child: Container(
                                      width: isTablet ? 120 : 108,
                                      height: isTablet ? 120 : 108,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFFFDE047)
                                            .withOpacity(0.22 * _glowAnim.value),
                                      ),
                                    ),
                                  ),

                                  // Sparkle tia sáng 8 hướng
                                  ..._buildSparkles(
                                      isTablet ? 70.0 : 60.0,
                                      _sparkleAnim.value),

                                  // Vòng tròn chính
                                  Transform.rotate(
                                    angle: _rotateAnim.value,
                                    child: Container(
                                      width: isTablet ? 110 : 96,
                                      height: isTablet ? 110 : 96,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEF08A),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFDE047)
                                                .withOpacity(0.6 * _glowAnim.value),
                                            blurRadius: 28,
                                            spreadRadius: 6,
                                          ),
                                        ],
                                        border: Border.all(
                                            color: Colors.white, width: 4),
                                      ),
                                      child: const Center(
                                        child: Text('⭐',
                                            style: TextStyle(fontSize: 48)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        'TUYỆT VỜI!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF059669),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bé đã hoàn thành xuất sắc!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4338CA),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: const Color(0xFFFEF08A), width: 2),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded,
                                color: Color(0xFFEAB308)),
                            SizedBox(width: 6),
                            Text(
                              '+5 Stars',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFCA8A04),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Nhận thêm 1 huy hiệu tích lũy',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/s9_daily_mission'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5E9),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Tiếp tục học ➔',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tia sáng 8 hướng xung quanh ngôi sao
  List<Widget> _buildSparkles(double radius, double opacity) {
    return List.generate(8, (i) {
      final angle = i * math.pi / 4;
      final dx = math.cos(angle) * radius;
      final dy = math.sin(angle) * radius;
      final isLong = i % 2 == 0;
      return Transform.translate(
        offset: Offset(dx, dy),
        child: Transform.rotate(
          angle: angle + math.pi / 2,
          child: Opacity(
            opacity: isLong ? opacity : opacity * 0.6,
            child: Container(
              width: isLong ? 4 : 3,
              height: isLong ? 16 : 10,
              decoration: BoxDecoration(
                color: const Color(0xFFFDE047),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFDE047).withOpacity(0.8),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────
// Confetti particle data
// ─────────────────────────────────────────
class _ConfettiParticle {
  final double x;       // 0..1 ngang màn hình
  final double delay;   // 0..1 offset thời gian
  final double size;
  final Color color;
  final double speed;
  final double drift;   // lắc ngang
  final int shape;      // 0=rect, 1=circle, 2=triangle

  const _ConfettiParticle({
    required this.x,
    required this.delay,
    required this.size,
    required this.color,
    required this.speed,
    required this.drift,
    required this.shape,
  });
}

// ─────────────────────────────────────────
// Confetti painter
// ─────────────────────────────────────────
class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress; // 0..1

  const _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      // Mỗi hạt có delay riêng
      final t = ((progress + p.delay) % 1.0) * p.speed;
      if (t > 1.0) continue;

      final double px = (p.x + math.sin(t * math.pi * 2) * p.drift) * size.width;
      final double py = t * (size.height + 60) - 30;

      final paint = Paint()
        ..color = p.color.withOpacity((1.0 - t * 0.6).clamp(0, 1));

      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(t * math.pi * 4);

      switch (p.shape) {
        case 0: // hình chữ nhật
          canvas.drawRect(
              Rect.fromCenter(
                  center: Offset.zero, width: p.size, height: p.size * 0.5),
              paint);
          break;
        case 1: // hình tròn
          canvas.drawCircle(Offset.zero, p.size * 0.4, paint);
          break;
        case 2: // tam giác
          final path = Path()
            ..moveTo(0, -p.size * 0.5)
            ..lineTo(p.size * 0.45, p.size * 0.4)
            ..lineTo(-p.size * 0.45, p.size * 0.4)
            ..close();
          canvas.drawPath(path, paint);
          break;
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}