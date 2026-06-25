import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Flutter Widget mô phỏng màn hình: LESSON
/// Flashcard sinh động: flip animation, bounce emoji, sparkle, progress dots, swipe

class S6lessonScreen extends StatefulWidget {
  const S6lessonScreen({super.key});

  @override
  State<S6lessonScreen> createState() => _S6lessonScreenState();
}

class _S6lessonScreenState extends State<S6lessonScreen>
    with TickerProviderStateMixin {
  int _currentLessonIndex = 0;

  final List<Map<String, dynamic>> _lessons = [
    {
      'letter': 'A',
      'letterLower': 'a',
      'word': 'Apple',
      'phonetic': '/ˈæpl/',
      'translation': 'Quả táo',
      'image': '🍎',
      'color': const Color(0xFFF43F5E),
      'bg': const Color(0xFFFFF1F2),
      'particles': ['🍃', '✨', '🌿', '⭐'],
    },
    {
      'letter': 'B',
      'letterLower': 'b',
      'word': 'Banana',
      'phonetic': '/bəˈnɑːnə/',
      'translation': 'Quả chuối',
      'image': '🍌',
      'color': const Color(0xFFEAB308),
      'bg': const Color(0xFFFEFCE8),
      'particles': ['🌟', '✨', '💛', '🌙'],
    },
    {
      'letter': 'C',
      'letterLower': 'c',
      'word': 'Cat',
      'phonetic': '/kæt/',
      'translation': 'Con mèo',
      'image': '🐱',
      'color': const Color(0xFFF97316),
      'bg': const Color(0xFFFFF7ED),
      'particles': ['🐾', '✨', '🎀', '💫'],
    },
    {
      'letter': 'D',
      'letterLower': 'd',
      'word': 'Dog',
      'phonetic': '/dɒɡ/',
      'translation': 'Con chó',
      'image': '🐶',
      'color': const Color(0xFF6366F1),
      'bg': const Color(0xFFEEF2FF),
      'particles': ['🦴', '✨', '🐾', '💙'],
    },
    {
      'letter': 'E',
      'letterLower': 'e',
      'word': 'Elephant',
      'phonetic': '/ˈelɪfənt/',
      'translation': 'Con voi',
      'image': '🐘',
      'color': const Color(0xFF8B5CF6),
      'bg': const Color(0xFFF5F3FF),
      'particles': ['💜', '✨', '🌿', '⭐'],
    },
  ];

  // Animations
  late AnimationController _flipCtrl;
  late AnimationController _bounceCtrl;
  late AnimationController _floatCtrl;
  late AnimationController _slideCtrl;
  late AnimationController _particleCtrl;
  late AnimationController _speakerCtrl;

  late Animation<double> _flipAnim;
  late Animation<double> _bounceAnim;
  late Animation<double> _floatAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _speakerAnim;

  bool _isSpeaking = false;
  bool _slideDirection = true; // true = slide từ phải vào

  @override
  void initState() {
    super.initState();

    // Flip card
    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOut));

    // Bounce emoji lên xuống
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _bounceAnim = Tween<double>(
      begin: 0,
      end: -12,
    ).animate(CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut));

    // Float chữ cái
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(
      begin: -4,
      end: 4,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    // Slide chuyển bài
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _slideCtrl.value = 1.0; // bắt đầu đã xong

    // Particle ambient
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Speaker pulse
    _speakerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _speakerAnim = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _speakerCtrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    _bounceCtrl.dispose();
    _floatCtrl.dispose();
    _slideCtrl.dispose();
    _particleCtrl.dispose();
    _speakerCtrl.dispose();
    super.dispose();
  }

  void _goTo(int index, bool fromRight) {
    setState(() {
      _slideDirection = fromRight;
      _currentLessonIndex = index;
    });
    _slideAnim = Tween<Offset>(
      begin: Offset(fromRight ? 1.2 : -1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _slideCtrl.forward(from: 0);
  }

  void _speak() async {
    setState(() => _isSpeaking = true);
    await _speakerCtrl.forward(from: 0);
    await _speakerCtrl.reverse();
    if (mounted) setState(() => _isSpeaking = false);
  }

  Map<String, dynamic> get _lesson => _lessons[_currentLessonIndex];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final Color accent = _lesson['color'] as Color;
    final Color bg = _lesson['bg'] as Color;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
          child: Column(
            children: [
              _buildTopBar(),
              _buildProgressDots(),
              const SizedBox(height: 8),
              Expanded(
                child: SlideTransition(
                  position: _slideAnim,
                  child: _buildCard(accent, isTablet),
                ),
              ),
              const SizedBox(height: 12),
              _buildNavButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top bar
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/s5_module'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.chevron_left, color: Color(0xFF64748B), size: 16),
                Text(
                  'Danh sách',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Bài ${_currentLessonIndex + 1} / ${_lessons.length}',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  // ── Progress dots
  Widget _buildProgressDots() {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_lessons.length, (i) {
          final bool done = i < _currentLessonIndex;
          final bool active = i == _currentLessonIndex;
          final Color c = _lesson['color'] as Color;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: active ? 28 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: done
                  ? c
                  : active
                  ? c
                  : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(6),
              boxShadow: active
                  ? [BoxShadow(color: c.withOpacity(0.4), blurRadius: 6)]
                  : [],
            ),
          );
        }),
      ),
    );
  }

  // ── Main flashcard
  Widget _buildCard(Color accent, bool isTablet) {
    final List<String> particles = List<String>.from(
      _lesson['particles'] as List,
    );

    return AnimatedBuilder(
      animation: Listenable.merge([_bounceAnim, _floatAnim, _particleCtrl]),
      builder: (_, __) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: accent.withOpacity(0.15), width: 2),
          ),
          child: Stack(
            children: [
              // Ambient particles ở 4 góc
              ..._buildAmbientParticles(particles, accent),

              // Nội dung chính
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Chữ hoa + chữ thường floating
                    Transform.translate(
                      offset: Offset(0, _floatAnim.value),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _lesson['letter']!,
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.w900,
                              color: accent,
                              height: 1,
                              shadows: [
                                Shadow(
                                  color: accent.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _lesson['letterLower']!,
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w700,
                              color: accent.withOpacity(0.55),
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Emoji bounce với vòng tròn gradient
                    _buildEmojiCircle(accent),

                    // Từ vựng + phiên âm + nghĩa
                    _buildWordSection(accent),

                    // Nút nghe phát âm
                    _buildSpeakButton(accent),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Emoji lớn bounce trong vòng tròn
  Widget _buildEmojiCircle(Color accent) {
    return AnimatedBuilder(
      animation: _bounceAnim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _bounceAnim.value),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Vòng glow ngoài
            Container(
              width: 136,
              height: 136,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withOpacity(0.1),
              ),
            ),
            // Vòng gradient chính
            Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [accent.withOpacity(0.9), accent],
                ),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.45),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _lesson['image']!,
                  style: const TextStyle(fontSize: 60),
                ),
              ),
            ),
            // Sparkle nhỏ xung quanh
            ..._buildMiniSparkles(accent),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMiniSparkles(Color accent) {
    return List.generate(6, (i) {
      final angle = i * math.pi / 3;
      final r = 72.0;
      return AnimatedBuilder(
        animation: _particleCtrl,
        builder: (_, __) {
          final t = (_particleCtrl.value + i * 0.16) % 1.0;
          final scale = math.sin(t * math.pi);
          return Transform.translate(
            offset: Offset(math.cos(angle) * r, math.sin(angle) * r),
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: i % 2 == 0 ? accent : Colors.amber,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: accent.withOpacity(0.5), blurRadius: 4),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ── Từ vựng section
  Widget _buildWordSection(Color accent) {
    return Column(
      children: [
        Text(
          _lesson['word']!,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _lesson['phonetic']!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withOpacity(0.25)),
          ),
          child: Text(
            _lesson['translation']!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
        ),
      ],
    );
  }

  // ── Nút nghe
  Widget _buildSpeakButton(Color accent) {
    return AnimatedBuilder(
      animation: _speakerAnim,
      builder: (_, child) => Transform.scale(
        scale: _isSpeaking ? _speakerAnim.value : 1.0,
        child: child,
      ),
      child: GestureDetector(
        onTap: _speak,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [accent, accent.withOpacity(0.8)]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  _isSpeaking
                      ? Icons.graphic_eq_rounded
                      : Icons.volume_up_rounded,
                  color: Colors.white,
                  size: 18,
                  key: ValueKey(_isSpeaking),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Nghe phát âm',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Ambient floating particles ở góc card
  List<Widget> _buildAmbientParticles(List<String> particles, Color accent) {
    final positions = [
      const Alignment(-0.9, -0.9),
      const Alignment(0.9, -0.9),
      const Alignment(-0.9, 0.9),
      const Alignment(0.9, 0.9),
    ];
    return List.generate(4, (i) {
      return AnimatedBuilder(
        animation: _particleCtrl,
        builder: (_, __) {
          final t = (_particleCtrl.value + i * 0.25) % 1.0;
          final dy = math.sin(t * math.pi * 2) * 6;
          return Positioned.fill(
            child: Align(
              alignment: positions[i],
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Transform.translate(
                  offset: Offset(0, dy),
                  child: Opacity(
                    opacity: 0.55,
                    child: Text(
                      particles[i % particles.length],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  // ── Nav buttons
  Widget _buildNavButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _currentLessonIndex == 0
                ? null
                : () => _goTo(_currentLessonIndex - 1, false),
            child: AnimatedOpacity(
              opacity: _currentLessonIndex == 0 ? 0.4 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 18,
                      color: Color(0xFF334155),
                    ),
                    Text(
                      'Trước',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (_currentLessonIndex < _lessons.length - 1) {
                _goTo(_currentLessonIndex + 1, true);
              } else {
                Navigator.pushNamed(context, '/s7_quiz');
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _currentLessonIndex == _lessons.length - 1
                      ? [const Color(0xFF8B5CF6), const Color(0xFF6366F1)]
                      : [const Color(0xFF10B981), const Color(0xFF059669)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color:
                        (_currentLessonIndex == _lessons.length - 1
                                ? const Color(0xFF6366F1)
                                : const Color(0xFF10B981))
                            .withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentLessonIndex == _lessons.length - 1
                        ? 'Làm Quiz! 🎯'
                        : 'Tiếp theo',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _currentLessonIndex == _lessons.length - 1
                        ? Icons.emoji_events_rounded
                        : Icons.chevron_right,
                    size: 18,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
