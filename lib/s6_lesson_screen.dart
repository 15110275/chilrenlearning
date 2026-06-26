import 'dart:math' as math;

import 'package:flutter/material.dart';

class S6lessonScreen extends StatefulWidget {
  const S6lessonScreen({super.key});

  @override
  State<S6lessonScreen> createState() => _S6lessonScreenState();
}

class _LessonItem {
  const _LessonItem({
    required this.letter,
    required this.lowercase,
    required this.word,
    required this.phonetic,
    required this.translation,
    required this.emoji,
    required this.color,
    required this.bg,
    required this.options,
  });

  final String letter;
  final String lowercase;
  final String word;
  final String phonetic;
  final String translation;
  final String emoji;
  final Color color;
  final Color bg;
  final List<_GameOption> options;
}

class _GameOption {
  const _GameOption({
    required this.emoji,
    required this.word,
    required this.isCorrect,
  });

  final String emoji;
  final String word;
  final bool isCorrect;
}

class _S6lessonScreenState extends State<S6lessonScreen>
    with TickerProviderStateMixin {
  final List<_LessonItem> _lessons = const [
    _LessonItem(
      letter: 'A',
      lowercase: 'a',
      word: 'Apple',
      phonetic: '/ae-pl/',
      translation: 'Quả táo',
      emoji: '🍎',
      color: Color(0xFFF43F5E),
      bg: Color(0xFFFFF1F2),
      options: [
        _GameOption(emoji: '🍎', word: 'Apple', isCorrect: true),
        _GameOption(emoji: '🍌', word: 'Banana', isCorrect: false),
        _GameOption(emoji: '⚽', word: 'Ball', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'B',
      lowercase: 'b',
      word: 'Ball',
      phonetic: '/bɔːl/',
      translation: 'Quả bóng',
      emoji: '⚽',
      color: Color(0xFF2563EB),
      bg: Color(0xFFEFF6FF),
      options: [
        _GameOption(emoji: '🍌', word: 'Banana', isCorrect: false),
        _GameOption(emoji: '⚽', word: 'Ball', isCorrect: true),
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'C',
      lowercase: 'c',
      word: 'Cat',
      phonetic: '/kæt/',
      translation: 'Con mèo',
      emoji: '🐱',
      color: Color(0xFFF97316),
      bg: Color(0xFFFFF7ED),
      options: [
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: true),
        _GameOption(emoji: '🐶', word: 'Dog', isCorrect: false),
        _GameOption(emoji: '🍎', word: 'Apple', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'D',
      lowercase: 'd',
      word: 'Dog',
      phonetic: '/dɒg/',
      translation: 'Con chó',
      emoji: '🐶',
      color: Color(0xFF10B981),
      bg: Color(0xFFECFDF5),
      options: [
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: false),
        _GameOption(emoji: '🐶', word: 'Dog', isCorrect: true),
        _GameOption(emoji: '⚽', word: 'Ball', isCorrect: false),
      ],
    ),
    _LessonItem(
      letter: 'E',
      lowercase: 'e',
      word: 'Elephant',
      phonetic: '/el-i-fənt/',
      translation: 'Con voi',
      emoji: '🐘',
      color: Color(0xFF8B5CF6),
      bg: Color(0xFFF5F3FF),
      options: [
        _GameOption(emoji: '🐘', word: 'Elephant', isCorrect: true),
        _GameOption(emoji: '🐱', word: 'Cat', isCorrect: false),
        _GameOption(emoji: '🍌', word: 'Banana', isCorrect: false),
      ],
    ),
  ];

  late final AnimationController _floatCtrl;
  late final AnimationController _speakerCtrl;
  late final AnimationController _celebrateCtrl;
  late final Animation<double> _floatAnim;
  late final Animation<double> _speakerAnim;

  int _currentIndex = 0;
  int _stars = 0;
  bool _playMode = false;
  bool _isSpeaking = false;
  String? _feedback;
  String? _selectedWord;
  final Set<int> _completedLessons = {};

  _LessonItem get _lesson => _lessons[_currentIndex];
  bool get _lessonComplete => _completedLessons.contains(_currentIndex);

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    _speakerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _speakerAnim = Tween<double>(
      begin: 1,
      end: 1.22,
    ).animate(CurvedAnimation(parent: _speakerCtrl, curve: Curves.elasticOut));

    _celebrateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _speakerCtrl.dispose();
    _celebrateCtrl.dispose();
    super.dispose();
  }

  Future<void> _speak() async {
    setState(() => _isSpeaking = true);
    await _speakerCtrl.forward(from: 0);
    await _speakerCtrl.reverse();
    if (mounted) setState(() => _isSpeaking = false);
  }

  void _chooseOption(_GameOption option) {
    setState(() {
      _selectedWord = option.word;
      if (option.isCorrect) {
        _feedback = 'Giỏi lắm! ${_lesson.letter} là ${_lesson.word}';
        if (_completedLessons.add(_currentIndex)) _stars += 3;
        _celebrateCtrl.forward(from: 0);
      } else {
        _feedback = 'Gần đúng rồi, bé thử lại nhé';
      }
    });
  }

  void _goToLesson(int index) {
    setState(() {
      _currentIndex = index;
      _playMode = false;
      _feedback = null;
      _selectedWord = null;
    });
  }

  void _nextAction() {
    if (!_playMode) {
      setState(() {
        _playMode = true;
        _feedback = 'Bé tìm hình của chữ ${_lesson.letter} nhé';
      });
      return;
    }

    if (!_lessonComplete) {
      setState(() => _feedback = 'Chọn đúng hình để mở bài tiếp theo nào');
      return;
    }

    if (_currentIndex == _lessons.length - 1) {
      Navigator.pushNamed(context, '/s7_quiz');
    } else {
      _goToLesson(_currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: _lesson.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            children: [
              _TopBar(
                lessonNumber: _currentIndex + 1,
                totalLessons: _lessons.length,
                stars: _stars,
                onBack: () => Navigator.pushNamed(context, '/s5_module'),
              ),
              const SizedBox(height: 12),
              _ProgressPills(
                total: _lessons.length,
                current: _currentIndex,
                completed: _completedLessons,
                color: _lesson.color,
              ),
              const SizedBox(height: 12),
              _ModeSwitch(
                playMode: _playMode,
                color: _lesson.color,
                onLearn: () => setState(() => _playMode = false),
                onPlay: () => setState(() => _playMode = true),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeOutBack,
                  child: _playMode
                      ? _buildGameCard(isTablet)
                      : _buildLearningCard(isTablet),
                ),
              ),
              const SizedBox(height: 12),
              _buildBottomControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearningCard(bool isTablet) {
    return Container(
      key: ValueKey('learn-${_lesson.letter}'),
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 30 : 22),
      decoration: _cardDecoration(_lesson.color),
      child: Stack(
        children: [
          _FloatingBubble(
            alignment: Alignment.topLeft,
            icon: '✨',
            color: _lesson.color,
          ),
          _FloatingBubble(
            alignment: Alignment.topRight,
            icon: '⭐',
            color: Colors.amber,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Học chữ ${_lesson.letter}',
                style: TextStyle(
                  color: _lesson.color,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              AnimatedBuilder(
                animation: _floatAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnim.value),
                    child: child,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _lesson.letter,
                      style: TextStyle(
                        height: 0.95,
                        fontSize: isTablet ? 120 : 92,
                        fontWeight: FontWeight.w900,
                        color: _lesson.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _lesson.lowercase,
                      style: TextStyle(
                        fontSize: isTablet ? 72 : 56,
                        fontWeight: FontWeight.w800,
                        color: _lesson.color.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              _EmojiBadge(
                emoji: _lesson.emoji,
                color: _lesson.color,
                size: isTablet ? 160 : 132,
              ),
              Column(
                children: [
                  Text(
                    _lesson.word,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _lesson.phonetic,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _lesson.translation,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _lesson.color,
                    ),
                  ),
                ],
              ),
              _SpeakButton(
                color: _lesson.color,
                isSpeaking: _isSpeaking,
                speakerAnim: _speakerAnim,
                onTap: _speak,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(bool isTablet) {
    return Container(
      key: ValueKey('game-${_lesson.letter}'),
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 28 : 18),
      decoration: _cardDecoration(_lesson.color),
      child: Stack(
        children: [
          Positioned.fill(child: _CelebrationStars(controller: _celebrateCtrl)),
          Column(
            children: [
              Text(
                'Chạm hoặc kéo hình đúng',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _lesson.color,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              DragTarget<_GameOption>(
                onWillAcceptWithDetails: (_) => true,
                onAcceptWithDetails: (details) => _chooseOption(details.data),
                builder: (context, candidates, rejected) {
                  final isHovering = candidates.isNotEmpty;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: isTablet ? 22 : 18,
                    ),
                    decoration: BoxDecoration(
                      color: isHovering
                          ? _lesson.color.withValues(alpha: 0.14)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: _lesson.color.withValues(
                          alpha: isHovering ? 0.7 : 0.24,
                        ),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _lesson.letter,
                          style: TextStyle(
                            fontSize: isTablet ? 70 : 54,
                            height: 1,
                            fontWeight: FontWeight.w900,
                            color: _lesson.color,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Đâu là ${_lesson.word}?',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              Expanded(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: isTablet ? 1.05 : 0.84,
                  children: _lesson.options.map(_buildGameOption).toList(),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: _feedback == null
                    ? const SizedBox(height: 42)
                    : Container(
                        key: ValueKey(_feedback),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: _lessonComplete
                              ? const Color(0xFFECFDF5)
                              : const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: _lessonComplete
                                ? const Color(0xFF86EFAC)
                                : const Color(0xFFFED7AA),
                          ),
                        ),
                        child: Text(
                          _feedback!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: _lessonComplete
                                ? const Color(0xFF059669)
                                : const Color(0xFFEA580C),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameOption(_GameOption option) {
    final isSelected = _selectedWord == option.word;
    final selectedColor = option.isCorrect
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    final card = GestureDetector(
      onTap: () => _chooseOption(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? selectedColor : const Color(0xFFE2E8F0),
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ? selectedColor : _lesson.color).withValues(
                alpha: isSelected ? 0.22 : 0.08,
              ),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(fit: BoxFit.contain, child: Text(option.emoji)),
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                option.word,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF334155),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return LongPressDraggable<_GameOption>(
      data: option,
      feedback: Material(
        color: Colors.transparent,
        child: Transform.scale(
          scale: 0.86,
          child: SizedBox(width: 120, height: 120, child: card),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.4, child: card),
      child: card,
    );
  }

  Widget _buildBottomControls() {
    final isLast = _currentIndex == _lessons.length - 1;
    final mainLabel = !_playMode
        ? 'Chơi thử'
        : !_lessonComplete
        ? 'Tìm hình đúng'
        : isLast
        ? 'Làm Quiz'
        : 'Bài tiếp';

    return Row(
      children: [
        Expanded(
          child: _RoundActionButton(
            label: 'Trước',
            icon: Icons.chevron_left_rounded,
            enabled: _currentIndex > 0,
            color: const Color(0xFF64748B),
            onTap: () => _goToLesson(_currentIndex - 1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: _RoundActionButton(
            label: mainLabel,
            icon: !_playMode
                ? Icons.extension_rounded
                : _lessonComplete
                ? Icons.chevron_right_rounded
                : Icons.touch_app_rounded,
            enabled: true,
            color: _lessonComplete || !_playMode
                ? _lesson.color
                : const Color(0xFFF59E0B),
            onTap: _nextAction,
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration(Color color) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      border: Border.all(color: color.withValues(alpha: 0.18), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.16),
          blurRadius: 26,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.lessonNumber,
    required this.totalLessons,
    required this.stars,
    required this.onBack,
  });

  final int lessonNumber;
  final int totalLessons;
  final int stars;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton.filledTonal(
          onPressed: onBack,
          icon: const Icon(Icons.chevron_left_rounded),
          color: const Color(0xFF475569),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Lesson $lessonNumber/$totalLessons',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Text(
            '⭐ $stars',
            style: const TextStyle(
              color: Color(0xFFD97706),
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressPills extends StatelessWidget {
  const _ProgressPills({
    required this.total,
    required this.current,
    required this.completed,
    required this.color,
  });

  final int total;
  final int current;
  final Set<int> completed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final active = index == current;
        final done = completed.contains(index);
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: done || active ? color : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(999),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.35),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({
    required this.playMode,
    required this.color,
    required this.onLearn,
    required this.onPlay,
  });

  final bool playMode;
  final Color color;
  final VoidCallback onLearn;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          _ModeChip(
            label: 'Học',
            icon: Icons.school_rounded,
            active: !playMode,
            color: color,
            onTap: onLearn,
          ),
          _ModeChip(
            label: 'Chơi',
            icon: Icons.extension_rounded,
            active: playMode,
            color: color,
            onTap: onPlay,
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.icon,
    required this.active,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: active ? Colors.white : const Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: active ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiBadge extends StatelessWidget {
  const _EmojiBadge({
    required this.emoji,
    required this.color,
    required this.size,
  });

  final String emoji;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Colors.white, color.withValues(alpha: 0.2)],
        ),
        border: Border.all(color: Colors.white, width: 6),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 68))),
    );
  }
}

class _SpeakButton extends StatelessWidget {
  const _SpeakButton({
    required this.color,
    required this.isSpeaking,
    required this.speakerAnim,
    required this.onTap,
  });

  final Color color;
  final bool isSpeaking;
  final Animation<double> speakerAnim;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: speakerAnim,
      builder: (context, child) {
        return Transform.scale(
          scale: isSpeaking ? speakerAnim.value : 1,
          child: child,
        );
      },
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        icon: Icon(
          isSpeaking ? Icons.graphic_eq_rounded : Icons.volume_up_rounded,
        ),
        label: const Text(
          'Nghe',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ),
    );
  }
}

class _RoundActionButton extends StatelessWidget {
  const _RoundActionButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool enabled;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        opacity: enabled ? 1 : 0.4,
        duration: const Duration(milliseconds: 180),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.28),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBubble extends StatelessWidget {
  const _FloatingBubble({
    required this.alignment,
    required this.icon,
    required this.color,
  });

  final Alignment alignment;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(icon, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}

class _CelebrationStars extends StatelessWidget {
  const _CelebrationStars({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: List.generate(10, (index) {
              final progress = Curves.easeOut.transform(controller.value);
              final angle = index * math.pi * 2 / 10;
              final radius = progress * 120;
              return Positioned(
                left:
                    MediaQuery.of(context).size.width / 2.7 +
                    math.cos(angle) * radius,
                top: 180 + math.sin(angle) * radius,
                child: Opacity(
                  opacity: (1 - progress).clamp(0, 1),
                  child: Transform.rotate(
                    angle: angle + progress,
                    child: const Text('⭐', style: TextStyle(fontSize: 18)),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
