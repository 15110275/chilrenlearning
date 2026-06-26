import 'package:flutter/material.dart';

/// Flutter Widget - PARENT DASHBOARD (KID-FRIENDLY ANIMATED VERSION)
/// Thiết kế sinh động, vui nhộn, phù hợp với trẻ em
/// Hiển thị đầy đủ: Header + Metrics + Shortcuts + Bottom Nav

class S17parentdashboardScreen extends StatefulWidget {
  const S17parentdashboardScreen({super.key});

  @override
  State<S17parentdashboardScreen> createState() => _S17parentdashboardState();
}

class _S17parentdashboardState extends State<S17parentdashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _contentAnimationController;
  late AnimationController _pulseController;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();

    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _headerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _contentAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _contentAnimationController.dispose();
    _pulseController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ============= SCROLLABLE CONTENT =============
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24.0 : 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ============= ANIMATED HEADER =============
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _headerAnimationController,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1).animate(
                            CurvedAnimation(
                              parent: _headerAnimationController,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          child: _buildKidFriendlyHeader(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ============= METRIC TILES WITH ANIMATIONS =============
                      ..._buildAnimatedMetricTiles((index) {
                        switch(index) {
                          case 0:
                            Navigator.pushNamed(context, '/s18_goal_setting');
                            break;
                          case 1:
                            Navigator.pushNamed(context, '/s16_parent_report');
                            break;
                          case 2:
                            Navigator.pushNamed(context, '/s10_streak');
                        }
                      }),
                      const SizedBox(height: 24),

                      // ============= QUICK SHORTCUTS SECTION =============
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _contentAnimationController,
                            curve: const Interval(
                              0.5,
                              1.0,
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _contentAnimationController,
                                  curve: const Interval(
                                    0.5,
                                    1.0,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                              ),
                          child: _buildQuickShortcuts(),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // ============= FIXED BOTTOM NAVIGATION =============
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24.0 : 16.0,
                vertical: 12.0,
              ),
              child: _buildAnimatedBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  // KID-FRIENDLY HEADER
  Widget _buildKidFriendlyHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD700), // Gold
            Color(0xFFFFA500), // Orange
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFA500).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/s15_multi_child');
            },
            child: Row(
              children: [
                // BOUNCING AVATAR
                ScaleTransition(
                  scale: Tween<double>(
                    begin: 1.0,
                    end: 1.15,
                  ).animate(_bounceController),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFFFD700),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🦁', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bé Minh',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '🎯 Level 2 • 4 Tuổi',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ANIMATED STAR BADGE
          ScaleTransition(
            scale: Tween<double>(
              begin: 1.0,
              end: 1.2,
            ).animate(_pulseController),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  RotationTransition(
                    turns: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(_pulseController),
                    child: const Text('⭐', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '120 Sao',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: Color(0xFFFF6B00),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ANIMATED METRIC TILES
  List<Widget> _buildAnimatedMetricTiles(Function(int) onTap) {
    final metrics = [
      {
        'emoji': '⏰',
        'icon': Icons.timer_outlined,
        'title': 'GIỜ HỌC HÔM NAY',
        'value': '15',
        'unit': 'Phút',
        'color': const Color(0xFF4F46E5),
        'bgGradient': [Color(0xFFEEF2FF), Color(0xFFDDD6FE)],
      },
      {
        'emoji': '✅',
        'icon': Icons.check_circle_outline_rounded,
        'title': 'TIẾN TRÌNH',
        'value': '46',
        'unit': '/ 76 Bài',
        'color': const Color(0xFF10B981),
        'bgGradient': [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
      },
      {
        'emoji': '🔥',
        'icon': Icons.local_fire_department_rounded,
        'title': 'CHUỖI LIÊN TỤC',
        'value': '6',
        'unit': 'Ngày',
        'color': const Color(0xFFF97316),
        'bgGradient': [Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
      },
    ];

    return List.generate(metrics.length, (index) {
      final metric = metrics[index];
      final delay = index * 0.15;

      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: InkWell(
          onTap: () {
            onTap(index);
          },
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: _contentAnimationController,
                curve: Interval(
                  delay,
                  (delay + 0.35).clamp(0, 1),
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(-0.3, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _contentAnimationController,
                      curve: Interval(
                        delay,
                        (delay + 0.35).clamp(0, 1),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
              child: _HoverScaleWidget(
                scale: 1.06,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: (metric['bgGradient'] as List<Color>),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: (metric['color'] as Color).withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (metric['color'] as Color).withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Big Emoji
                          ScaleTransition(
                            scale: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: _contentAnimationController,
                                curve: Interval(
                                  delay + 0.1,
                                  (delay + 0.35).clamp(0, 1),
                                  curve: Curves.elasticOut,
                                ),
                              ),
                            ),
                            child: Text(
                              metric['emoji'] as String,
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                metric['title'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: (metric['color'] as Color).withOpacity(
                                    0.7,
                                  ),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    metric['value'] as String,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: metric['color'] as Color,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    metric['unit'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (metric['color'] as Color)
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Progress Indicator
                      ScaleTransition(
                        scale: Tween<double>(begin: 0, end: 1).animate(
                          CurvedAnimation(
                            parent: _contentAnimationController,
                            curve: Interval(
                              delay + 0.15,
                              (delay + 0.4).clamp(0, 1),
                              curve: Curves.elasticOut,
                            ),
                          ),
                        ),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (metric['color'] as Color).withOpacity(0.2),
                            border: Border.all(
                              color: metric['color'] as Color,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              metric['icon'] as IconData,
                              color: metric['color'] as Color,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // QUICK SHORTCUTS SECTION
  Widget _buildQuickShortcuts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎮 CẤU HÌNH NHANH',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildQuickButton(
                emoji: '🎯',
                title: 'Mục tiêu',
                subtitle: '5 bài/15m',
                color: const Color(0xFF6366F1),
                delay: 0.0,
                onTap: () {
                  Navigator.pushNamed(context, '/s18_goal_setting');
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildQuickButton(
                emoji: '⏳',
                title: 'Thời gian',
                subtitle: '30m tối đa',
                color: const Color(0xFFEC4899),
                delay: 0.1,
                onTap: () {
                  Navigator.pushNamed(context, '/s19_screen_time');
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildQuickButton(
                emoji: '📂',
                title: 'Chủ đề học',
                subtitle: 'Quản lý',
                color: const Color(0xFF10B981),
                delay: 0.2,
                onTap: () {
                  Navigator.pushNamed(context, '/s22_voice_chat');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickButton({
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required double delay,
    required VoidCallback onTap,
  }) {
    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _contentAnimationController,
        curve: Interval(
          0.5 + delay,
          (0.8 + delay).clamp(0, 1),
          curve: Curves.easeOut,
        ),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.7, end: 1).animate(animation),
        child: _HoverScaleWidget(
          scale: 1.08,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.12), color.withOpacity(0.06)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: color.withOpacity(0.25), width: 2),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ANIMATED BOTTOM NAVIGATION
  Widget _buildAnimatedBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavButton(
            0,
            '🏠',
            'Trang chủ',
            const Color(0xFF4F46E5),
            () {
              Navigator.pushNamed(context, '/s4_home');
            },
          ),
          _buildBottomNavButton(
            1,
            '📊',
            'Báo cáo',
            const Color(0xFF10B981),
            () {
              Navigator.pushNamed(context, '/s16_parent_report');
            },
          ),
          _buildBottomNavButton(
            2,
            '⚙️',
            'Cài đặt',
            const Color(0xFFF97316),
            () {
              Navigator.pushNamed(context, '/s20_parent_settings');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavButton(
    int index,
    String emoji,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    final isSelected = index == 0;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? Border.all(color: color.withOpacity(0.4), width: 2)
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: isSelected
                    ? Tween<double>(begin: 1, end: 1.25).animate(
                        CurvedAnimation(
                          parent: _contentAnimationController,
                          curve: Curves.elasticOut,
                        ),
                      )
                    : AlwaysStoppedAnimation(1.0),
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: isSelected ? color : const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CUSTOM HOVER SCALE WIDGET
class _HoverScaleWidget extends StatefulWidget {
  final Widget child;
  final double scale;

  const _HoverScaleWidget({required this.child, this.scale = 1.05});

  @override
  State<_HoverScaleWidget> createState() => _HoverScaleWidgetState();
}

class _HoverScaleWidgetState extends State<_HoverScaleWidget>
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
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}
