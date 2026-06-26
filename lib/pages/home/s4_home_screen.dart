import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Flutter Widget mô phỏng màn hình: HOME
/// Sinh động: mascot float, card bounce-in, streak fire, progress animated, particles

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _selectedNav = 0;

  // Animations
  late AnimationController _floatCtrl;
  late AnimationController _particleCtrl;
  late AnimationController _progressCtrl;
  late AnimationController _cardCtrl;
  late AnimationController _starCtrl;

  late Animation<double> _floatAnim;
  late Animation<double> _progressAnim;
  late Animation<double> _starAnim;

  final List<_FloatingEmoji> _floatingEmojis = [];
  final math.Random _rng = math.Random();

  final List<Map<String, dynamic>> _categories = [
    {
      'display': 'ABC',
      'title': 'Bảng chữ cái',
      'badge': '90%',
      'progress': 0.9,
      'color': const Color(0xFF0284C7),
      'light': const Color(0xFFE0F2FE),
      'bg': const Color(0xFFF0F9FF),
      'emoji': '📖',
      'route': '/s5_module',
    },
    {
      'display': '123',
      'title': 'Chữ số',
      'badge': '60%',
      'progress': 0.6,
      'color': const Color(0xFFD97706),
      'light': const Color(0xFFFEF3C7),
      'bg': const Color(0xFFFFFBEB),
      'emoji': '🔢',
      'route': '/s5_module',
    },
    {
      'display': '🦁',
      'title': 'Động vật',
      'badge': '70%',
      'progress': 0.7,
      'color': const Color(0xFF059669),
      'light': const Color(0xFFD1FAE5),
      'bg': const Color(0xFFECFDF5),
      'emoji': '🐾',
      'route': '/s5_module',
    },
    {
      'display': '🎨',
      'title': 'Màu sắc',
      'badge': 'Xong!',
      'progress': 1.0,
      'color': const Color(0xFFDB2777),
      'light': const Color(0xFFFCE7F3),
      'bg': const Color(0xFFFDF2F8),
      'emoji': '🌈',
      'route': '/s5_module',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Float mascot
    _floatCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200))
      ..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -5, end: 5).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    // Particles ambient
    _particleCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat();

    // Progress bar animate on enter
    _progressCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _progressAnim = CurvedAnimation(parent: _progressCtrl, curve: Curves.easeOut);
    _progressCtrl.forward();

    // Cards stagger bounce-in
    _cardCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _cardCtrl.forward();

    // Star pulse
    _starCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _starAnim = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _starCtrl, curve: Curves.easeInOut));

    // Generate floating emojis
    _floatingEmojis.addAll(List.generate(10, (i) => _FloatingEmoji(
      emoji: ['⭐', '✨', '🌟', '💫', '📚', '🎯', '🏆', '🎉'][i % 8],
      x: _rng.nextDouble(),
      y: _rng.nextDouble() * 0.5,
      size: 12 + _rng.nextDouble() * 10,
      speed: 0.2 + _rng.nextDouble() * 0.3,
      phase: _rng.nextDouble(),
    )));
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _particleCtrl.dispose();
    _progressCtrl.dispose();
    _cardCtrl.dispose();
    _starCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final bool isTablet = sw > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      body: SafeArea(
        child: Stack(
          children: [
            // Ambient floating emojis
            _buildAmbientParticles(),

            // Main content
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 24 : 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 10),
                  _buildStreakAndGoal(),
                  const SizedBox(height: 14),
                  _buildSectionLabel('CHỌN CHỦ ĐỀ HỌC:'),
                  const SizedBox(height: 10),
                  Expanded(child: _buildGrid(isTablet)),
                  _buildNavBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Top bar: avatar + name + stars
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05),
              blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          // Mascot float
          AnimatedBuilder(
            animation: _floatAnim,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, _floatAnim.value),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFEF08A), Color(0xFFFBBF24)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFFFBBF24).withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: const Center(child: Text('🦁', style: TextStyle(fontSize: 22))),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Bin Bin',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B))),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Level 2 🎖️',
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800,
                            color: Color(0xFFD97706))),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Stars badge với pulse
          AnimatedBuilder(
            animation: _starAnim,
            builder: (_, child) => Transform.scale(scale: _starAnim.value, child: child),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFFEF9C3), Color(0xFFFEF08A)]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFDE047), width: 1.5),
                boxShadow: [
                  BoxShadow(color: const Color(0xFFFBBF24).withOpacity(0.3),
                      blurRadius: 8),
                ],
              ),
              child: const Row(
                children: [
                  Text('⭐', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 4),
                  Text('120',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900,
                          color: Color(0xFFD97706))),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Streak fire
          _buildStreakBadge(),
        ],
      ),
    );
  }

  Widget _buildStreakBadge() {
    return AnimatedBuilder(
      animation: _floatAnim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _floatAnim.value * 0.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFFFB923C), Color(0xFFEF4444)]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: const Color(0xFFF97316).withOpacity(0.4),
                  blurRadius: 8),
            ],
          ),
          child: const Row(
            children: [
              Text('🔥', style: TextStyle(fontSize: 13)),
              SizedBox(width: 3),
              Text('7', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900,
                  color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  // ── Streak + goal section
  Widget _buildStreakAndGoal() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04),
              blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('🎯', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 6),
                  Text('Mục tiêu hôm nay: 5 bài',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,
                          color: Color(0xFF334155))),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFED7AA)),
                ),
                child: const Text('2 / 5',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900,
                        color: Color(0xFFF97316))),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Animated progress bar
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (_, __) {
              return Stack(
                children: [
                  // Background track
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Fill
                  FractionallySizedBox(
                    widthFactor: 0.4 * _progressAnim.value,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFFFB923C), Color(0xFFF97316)]),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFFF97316).withOpacity(0.4),
                              blurRadius: 6),
                        ],
                      ),
                    ),
                  ),
                  // Shine overlay
                  FractionallySizedBox(
                    widthFactor: 0.4 * _progressAnim.value,
                    child: Container(
                      height: 5,
                      margin: const EdgeInsets.only(top: 2, left: 4, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          // Day streak pills
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final bool done = i < 5;
              final bool today = i == 4;
              return Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done
                          ? (today ? const Color(0xFFF97316) : const Color(0xFFFED7AA))
                          : const Color(0xFFF1F5F9),
                      border: today
                          ? Border.all(color: const Color(0xFFF97316), width: 2.5)
                          : null,
                      boxShadow: done
                          ? [BoxShadow(
                          color: const Color(0xFFF97316).withOpacity(0.25),
                          blurRadius: 6)]
                          : [],
                    ),
                    child: Center(
                      child: Text(done ? '✓' : '',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: today ? Colors.white : const Color(0xFFF97316))),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(['T2','T3','T4','T5','T6','T7','CN'][i],
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: done ? const Color(0xFFF97316) : const Color(0xFFCBD5E1))),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900,
                color: Color(0xFF64748B), letterSpacing: 1.0)),
      ],
    );
  }

  // ── Category grid
  Widget _buildGrid(bool isTablet) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.95,
      ),
      itemCount: _categories.length,
      itemBuilder: (_, i) {
        // Stagger bounce-in
        final delay = i * 0.15;
        return AnimatedBuilder(
          animation: _cardCtrl,
          builder: (_, child) {
            final t = (((_cardCtrl.value - delay) / (1 - delay)).clamp(0.0, 1.0));
            final curve = Curves.elasticOut.transform(t);
            return Transform.scale(
              scale: curve,
              child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
            );
          },
          child: _buildCategoryCard(i),
        );
      },
    );
  }

  Widget _buildCategoryCard(int i) {
    final cat = _categories[i];
    final Color accent = cat['color'] as Color;
    final double progress = cat['progress'] as double;
    final bool done = progress >= 1.0;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, cat['route'] as String),
      child: AnimatedBuilder(
        animation: _particleCtrl,
        builder: (_, __) {
          final shimmer = math.sin(_particleCtrl.value * math.pi * 2 + i) * 0.5 + 0.5;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: done
                    ? accent.withOpacity(0.5 + shimmer * 0.3)
                    : (cat['light'] as Color),
                width: done ? 2.5 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(0.12 + shimmer * 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon + done check overlay
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (cat['light'] as Color),
                          boxShadow: [
                            BoxShadow(
                                color: accent.withOpacity(0.2),
                                blurRadius: 10),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            cat['display'] as String,
                            style: TextStyle(
                              fontSize: (cat['display'] as String).length > 1 ? 20 : 30,
                              fontWeight: FontWeight.w900,
                              color: accent,
                            ),
                          ),
                        ),
                      ),
                      if (done)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Center(
                            child: Text('✓',
                                style: TextStyle(fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white)),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(cat['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w800,
                          color: Color(0xFF334155))),
                  const SizedBox(height: 6),
                  // Mini progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AnimatedBuilder(
                      animation: _progressAnim,
                      builder: (_, __) => LinearProgressIndicator(
                        value: progress * _progressAnim.value,
                        minHeight: 5,
                        backgroundColor: (cat['light'] as Color),
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: done ? accent : (cat['bg'] as Color),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      done ? '✅ Hoàn tất' : '${cat['badge']} Học',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: done ? Colors.white : accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Ambient particles
  Widget _buildAmbientParticles() {
    return AnimatedBuilder(
      animation: _particleCtrl,
      builder: (_, __) => LayoutBuilder(
        builder: (ctx, box) => Stack(
          children: _floatingEmojis.map((p) {
            final t = (_particleCtrl.value * p.speed + p.phase) % 1.0;
            final dy = math.sin(t * math.pi * 2) * 14;
            final dx = math.cos(t * math.pi * 1.5) * 8;
            final opacity = (0.15 + math.sin(t * math.pi) * 0.15).clamp(0.05, 0.3);
            return Positioned(
              left: p.x * box.maxWidth + dx,
              top: p.y * (box.maxHeight > 0 ? box.maxHeight : 700) + dy,
              child: Opacity(
                opacity: opacity,
                child: Text(p.emoji, style: TextStyle(fontSize: p.size)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── Bottom nav
  Widget _buildNavBar() {
    final items = [
      {'emoji': '🏠', 'label': 'Trang chủ', 'route': ''},
      {'emoji': '🗺️', 'label': 'Bản đồ', 'route': '/s12_map'},
      {'emoji': '🎁', 'label': 'Phần thưởng', 'route': '/s14_reward_shop'},
      {'emoji': '🔒', 'label': 'Phụ huynh', 'route': '/s3_parent_gate'},
    ];

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06),
              blurRadius: 10, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final bool active = i == _selectedNav;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedNav = i);
              if ((items[i]['route'] as String).isNotEmpty) {
                Navigator.pushNamed(context, items[i]['route'] as String);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF6366F1).withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: active ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(items[i]['emoji']!,
                        style: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 2),
                  Text(items[i]['label']!,
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: active
                              ? const Color(0xFF6366F1)
                              : const Color(0xFF94A3B8))),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FloatingEmoji {
  final String emoji;
  final double x, y, size, speed, phase;
  const _FloatingEmoji({
    required this.emoji, required this.x, required this.y,
    required this.size, required this.speed, required this.phase,
  });
}