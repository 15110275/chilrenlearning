import 'package:flutter/material.dart';

/// Flutter Widget - PARENT REPORT (ANIMATED & KID-FRIENDLY VERSION)
/// Thêm animations, gradients, emojis để sinh động hơn
/// Responsive cho Mobile & Tablet

class S16reportScreen extends StatefulWidget {
  const S16reportScreen({super.key});

  @override
  State<S16reportScreen> createState() => _S16reportScreenState();
}

class _S16reportScreenState extends State<S16reportScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _contentController;
  late AnimationController _barController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _barController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _contentController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _barController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _contentController.dispose();
    _barController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedProgressRow(
      int index,
      String label,
      String emoji,
      double value,
      String text,
      Color color,
      List<Color> gradientColors,
      ) {
    final delay = index * 0.12;

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _contentController,
          curve: Interval(delay, (delay + 0.3).clamp(0, 1),
              curve: Curves.easeOut),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.3, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _contentController,
            curve: Interval(delay, (delay + 0.3).clamp(0, 1),
                curve: Curves.easeOut),
          ),
        ),
        child: _HoverWidget(
          scale: 1.05,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(emoji, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    ScaleTransition(
                      scale: Tween<double>(begin: 1, end: 1.15).animate(
                        CurvedAnimation(
                          parent: _pulseController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: color.withOpacity(0.4)),
                        ),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Animated Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _contentController.value > (delay + 0.15)
                        ? (((_contentController.value - (delay + 0.15)) /
                        0.15)
                        .clamp(0, 1) *
                        value)
                        : 0,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBar(
      int dayIndex,
      double value,
      String label,
      String emoji,
      ) {
    final maxHeight = 100.0;
    final delay = dayIndex * 0.1;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Value Text
          ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: _barController,
                curve: Interval(delay, (delay + 0.2).clamp(0, 1),
                    curve: Curves.elasticOut),
              ),
            ),
            child: Text(
              '${value.toInt()}m',
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Color(0xFF6366F1),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Animated Bar
          Expanded(
            child: AnimatedBuilder(
              animation: _barController,
              builder: (context, child) {
                final progress = (_barController.value - delay).clamp(0, 0.2) / 0.2;
                return Container(
                  width: 16,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6366F1),
                        const Color(0xFF4F46E5),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  height: (maxHeight * progress).clamp(0, maxHeight),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          // Day Label with Emoji
          Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 14)),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ============= HEADER =============
            FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _headerController,
                  curve: Curves.easeOut,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.2),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _headerController,
                    curve: Curves.easeOut,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScaleTransition(
                            scale: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: _headerController,
                                curve: const Interval(0.2, 0.6,
                                    curve: Curves.elasticOut),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () =>
                                    Navigator.pop(context),
                              ),
                            ),
                          ),
                          const Text(
                            '📊 BÁO CÁO TUẦN',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.8,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 36),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          const Text(
                            '📚 Tiến Độ Học Tập Của Bé',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: const Text(
                              '📅 Tuần: 01/07 - 07/07',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ============= SCROLLABLE CONTENT =============
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress Rows
                      _buildAnimatedProgressRow(
                        0,
                        'Bảng chữ cái (ABC)',
                        '🔤',
                        0.8,
                        '80%',
                        const Color(0xFF10B981),
                        [
                          const Color(0xFFECFDF5),
                          const Color(0xFFD1FAE5),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildAnimatedProgressRow(
                        1,
                        'Chữ số (Numbers)',
                        '🔢',
                        0.6,
                        '60%',
                        const Color(0xFF0EA5E9),
                        [
                          const Color(0xFFEFF6FF),
                          const Color(0xFFDDD6FE),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildAnimatedProgressRow(
                        2,
                        'Động vật (Animals)',
                        '🦁',
                        0.45,
                        '45%',
                        const Color(0xFFF59E0B),
                        [
                          const Color(0xFFFEF3C7),
                          const Color(0xFFFFDC82),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildAnimatedProgressRow(
                        3,
                        'Màu sắc (Colors)',
                        '🎨',
                        0.3,
                        '30%',
                        const Color(0xFFEF4444),
                        [
                          const Color(0xFFFEE2E2),
                          const Color(0xFFFECACA),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Bar Chart Section
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _contentController,
                            curve: const Interval(0.6, 1.0,
                                curve: Curves.easeOut),
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _contentController,
                              curve: const Interval(0.6, 1.0,
                                  curve: Curves.easeOut),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFF8FAFC),
                                  const Color(0xFFEEF2FF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '⏱️ THỜI LƯỢNG HỌC HÀNG NGÀY',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF4F46E5),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Phút học mỗi ngày trong tuần',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 140,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      _buildAnimatedBar(
                                        0,
                                        15,
                                        'T2',
                                        '🔵',
                                      ),
                                      _buildAnimatedBar(
                                        1,
                                        25,
                                        'T3',
                                        '🟢',
                                      ),
                                      _buildAnimatedBar(
                                        2,
                                        45,
                                        'T4',
                                        '🟡',
                                      ),
                                      _buildAnimatedBar(
                                        3,
                                        10,
                                        'T5',
                                        '⚪',
                                      ),
                                      _buildAnimatedBar(
                                        4,
                                        30,
                                        'T6',
                                        '🔴',
                                      ),
                                      _buildAnimatedBar(
                                        5,
                                        20,
                                        'T7',
                                        '🟣',
                                      ),
                                      _buildAnimatedBar(
                                        6,
                                        35,
                                        'CN',
                                        '🌈',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Button
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _contentController,
                            curve: const Interval(0.8, 1.0,
                                curve: Curves.easeOut),
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _contentController,
                              curve: const Interval(0.8, 1.0,
                                  curve: Curves.easeOut),
                            ),
                          ),
                          child: _HoverWidget(
                            scale: 1.05,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/s17_parent_dashboard');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4F46E5),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  shadowColor: const Color(0xFF4F46E5)
                                      .withOpacity(0.4),
                                ),
                                child: const Text(
                                  '🏠 Mở Parent Dashboard ➔',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CUSTOM HOVER WIDGET
class _HoverWidget extends StatefulWidget {
  final Widget child;
  final double scale;

  const _HoverWidget({
    required this.child,
    this.scale = 1.05,
  });

  @override
  State<_HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<_HoverWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}