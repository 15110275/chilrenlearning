import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Flutter Widget mô phỏng màn hình: ONBOARDING
/// Sinh động: PageView swipe, emoji bounce+float, background blobs, particles, slide transition

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageCtrl = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'emoji': '🎒',
      'title': 'Học Tập Vui Vẻ',
      'subtitle': 'HỌC QUA HÌNH ẢNH SINH ĐỘNG',
      'desc': 'Bảng chữ cái, chữ số và con vật được thiết kế bắt mắt, kích thích tối đa trí tưởng tượng và tư duy cho bé.',
      'color': const Color(0xFF6366F1),
      'bg1': const Color(0xFFEEF2FF),
      'bg2': const Color(0xFFC7D2FE),
      'particles': ['📚', '✏️', '🌟', '🎨', '🔤'],
    },
    {
      'emoji': '🔊',
      'title': 'Phát Âm Bản Xứ',
      'subtitle': 'CHUẨN GIỌNG PHÁT ÂM ANH - MỸ',
      'desc': 'Hệ thống âm thanh ngoại tuyến giọng chuẩn bản ngữ, giúp trẻ bắt chước phát âm chính xác từ nhỏ.',
      'color': const Color(0xFF0EA5E9),
      'bg1': const Color(0xFFEFF6FF),
      'bg2': const Color(0xFFBAE6FD),
      'particles': ['🎵', '🎶', '🎤', '🔈', '💬'],
    },
    {
      'emoji': '📡',
      'title': 'Offline An Toàn',
      'subtitle': 'KHÔNG CẦN WIFI - KHÔNG QUẢNG CÁO',
      'desc': 'Trải nghiệm học tập an toàn tuyệt đối, không lo bé bấm nhầm quảng cáo độc hại hay tự mua hàng.',
      'color': const Color(0xFF10B981),
      'bg1': const Color(0xFFECFDF5),
      'bg2': const Color(0xFFA7F3D0),
      'particles': ['🛡️', '✅', '🏠', '💚', '🔒'],
    },
  ];

  // Controllers
  late AnimationController _bounceCtrl;
  late AnimationController _floatCtrl;
  late AnimationController _particleCtrl;
  late AnimationController _blobCtrl;
  late AnimationController _fadeCtrl;

  late Animation<double> _bounceAnim;
  late Animation<double> _floatAnim;
  late Animation<double> _fadeAnim;

  final math.Random _rng = math.Random();
  late List<_ParticleData> _particles;

  @override
  void initState() {
    super.initState();

    _bounceCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600))
      ..repeat(reverse: true);
    _bounceAnim = Tween<double>(begin: 0, end: -18).animate(
        CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut));

    _floatCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2800))
      ..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    _particleCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 5))
      ..repeat();

    _blobCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 420));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.value = 1.0;

    _particles = _generateParticles();
  }

  List<_ParticleData> _generateParticles() {
    return List.generate(14, (i) => _ParticleData(
      x: _rng.nextDouble(),
      y: _rng.nextDouble() * 0.7 + 0.05,
      size: 16 + _rng.nextDouble() * 14,
      speed: 0.3 + _rng.nextDouble() * 0.4,
      phase: _rng.nextDouble(),
      emojiIndex: i % 5,
    ));
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _bounceCtrl.dispose();
    _floatCtrl.dispose();
    _particleCtrl.dispose();
    _blobCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _fadeCtrl.forward(from: 0);
    _pageCtrl.animateToPage(index,
        duration: const Duration(milliseconds: 420), curve: Curves.easeInOut);
    setState(() => _currentIndex = index);
  }

  Map<String, dynamic> get _slide => _slides[_currentIndex];

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final bool isTablet = sw > 600;
    final Color accent = _slide['color'] as Color;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              (_slide['bg1'] as Color),
              (_slide['bg2'] as Color).withOpacity(0.4),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // ── Background animated blobs
              _buildBlobs(accent),

              // ── Floating particles
              _buildParticles(),

              // ── Main layout
              Column(
                children: [
                  // Skip button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, '/s3_parent_gate'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: accent.withOpacity(0.25), width: 1.5),
                          ),
                          child: Text(
                            'Bỏ qua ➔',
                            style: TextStyle(
                                color: accent,
                                fontWeight: FontWeight.w800,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // PageView content
                  Expanded(
                    child: PageView.builder(
                      controller: _pageCtrl,
                      onPageChanged: (i) =>
                          setState(() => _currentIndex = i),
                      itemCount: _slides.length,
                      itemBuilder: (_, i) => _buildSlide(_slides[i], isTablet),
                    ),
                  ),

                  // Dots + button
                  _buildBottomSection(accent, isTablet),
                  const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Slide content
  Widget _buildSlide(Map<String, dynamic> slide, bool isTablet) {
    final Color accent = slide['color'] as Color;
    final bool isActive = slide == _slide;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji lớn với bounce + float + vòng tròn glow
          AnimatedBuilder(
            animation: Listenable.merge([_bounceAnim, _floatAnim, _blobCtrl]),
            builder: (_, __) {
              return Transform.translate(
                offset: isActive
                    ? Offset(_floatAnim.value * 0.3, _bounceAnim.value)
                    : Offset.zero,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow ring ngoài cùng
                    AnimatedBuilder(
                      animation: _blobCtrl,
                      builder: (_, __) => Transform.scale(
                        scale: 1.0 + _blobCtrl.value * 0.08,
                        child: Container(
                          width: isTablet ? 200 : 168,
                          height: isTablet ? 200 : 168,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accent.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    // Vòng giữa
                    Container(
                      width: isTablet ? 164 : 138,
                      height: isTablet ? 164 : 138,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accent.withOpacity(0.18),
                      ),
                    ),
                    // Vòng chính trắng
                    Container(
                      width: isTablet ? 136 : 114,
                      height: isTablet ? 136 : 114,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withOpacity(0.35),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                            color: accent.withOpacity(0.2), width: 3),
                      ),
                      child: Center(
                        child: Text(
                          slide['emoji']!,
                          style: TextStyle(fontSize: isTablet ? 68 : 56),
                        ),
                      ),
                    ),
                    // Sparkle dots xung quanh
                    ..._buildOrbitDots(accent, isActive),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: isTablet ? 40 : 28),

          // Title
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: Text(
              slide['title']!,
              key: ValueKey(slide['title']),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 30 : 22,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F172A),
                height: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle badge
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withOpacity(0.3)),
            ),
            child: Text(
              slide['subtitle']!,
              style: TextStyle(
                fontSize: isTablet ? 13 : 10,
                fontWeight: FontWeight.w900,
                color: accent,
                letterSpacing: 0.8,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Text(
              slide['desc']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 15 : 13,
                color: Colors.grey[600],
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Orbit dots xung quanh emoji
  List<Widget> _buildOrbitDots(Color accent, bool active) {
    return List.generate(6, (i) {
      final angle = i * math.pi / 3;
      final r = 72.0;
      return AnimatedBuilder(
        animation: _particleCtrl,
        builder: (_, __) {
          final t = (_particleCtrl.value + i / 6) % 1.0;
          final scale = active ? (0.5 + math.sin(t * math.pi * 2) * 0.5) : 0.0;
          return Transform.translate(
            offset: Offset(math.cos(angle) * r, math.sin(angle) * r),
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: i % 2 == 0 ? 12 : 8,
                height: i % 2 == 0 ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i % 3 == 0
                      ? accent
                      : i % 3 == 1
                      ? Colors.amber
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: accent.withOpacity(0.5), blurRadius: 6)
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ── Blobs nền
  Widget _buildBlobs(Color accent) {
    return AnimatedBuilder(
      animation: _blobCtrl,
      builder: (_, __) {
        final t = _blobCtrl.value;
        return Stack(
          children: [
            Positioned(
              top: -60 + t * 20,
              right: -60 + t * 10,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              bottom: -80 + t * 15,
              left: -50,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              top: 120 + t * 30,
              left: -30 + t * 5,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withOpacity(0.07),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Floating particles
  Widget _buildParticles() {
    final List<String> emojis =
    List<String>.from(_slide['particles'] as List);
    return AnimatedBuilder(
      animation: _particleCtrl,
      builder: (_, __) {
        return LayoutBuilder(builder: (ctx, box) {
          return Stack(
            children: _particles.map((p) {
              final t = (_particleCtrl.value * p.speed + p.phase) % 1.0;
              final dy = math.sin(t * math.pi * 2) * 18;
              final dx = math.cos(t * math.pi * 1.3) * 10;
              final opacity = 0.25 + math.sin(t * math.pi) * 0.25;
              return Positioned(
                left: p.x * box.maxWidth + dx,
                top: p.y * (box.maxHeight > 0 ? box.maxHeight : 600) + dy,
                child: Opacity(
                  opacity: opacity.clamp(0.1, 0.5),
                  child: Text(
                    emojis[p.emojiIndex % emojis.length],
                    style: TextStyle(fontSize: p.size),
                  ),
                ),
              );
            }).toList(),
          );
        });
      },
    );
  }

  // ── Bottom: dots + button
  Widget _buildBottomSection(Color accent, bool isTablet) {
    return Column(
      children: [
        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (i) {
            final bool active = i == _currentIndex;
            return GestureDetector(
              onTap: () => _goToPage(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 10,
                width: active ? 30 : 10,
                decoration: BoxDecoration(
                  color: active ? accent : accent.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: active
                      ? [
                    BoxShadow(
                        color: accent.withOpacity(0.4),
                        blurRadius: 6)
                  ]
                      : [],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        // Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: GestureDetector(
            onTap: () {
              if (_currentIndex < _slides.length - 1) {
                _goToPage(_currentIndex + 1);
              } else {
                Navigator.pushReplacementNamed(
                    context, '/s3_parent_gate');
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 320),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, accent.withOpacity(0.75)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.45),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentIndex < _slides.length - 1
                        ? 'Tiếp Theo'
                        : 'Bắt Đầu Ngay! 🚀',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: isTablet ? 18 : 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (_currentIndex < _slides.length - 1)
                    const Icon(Icons.arrow_forward_rounded,
                        color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// Particle data
// ─────────────────────────────────────────
class _ParticleData {
  final double x, y, size, speed, phase;
  final int emojiIndex;
  const _ParticleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.phase,
    required this.emojiIndex,
  });
}