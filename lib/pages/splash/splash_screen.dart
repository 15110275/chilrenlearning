import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _progress = 0.0;

  late AnimationController _bearController;
  late Animation<double> _bearScale;

  @override
  void initState() {
    super.initState();

    _bearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _bearScale = Tween<double>(
      begin: 0.95,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: _bearController,
        curve: Curves.easeInOut,
      ),
    );

    _startLoading();
  }

  void _startLoading() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;

      setState(() {
        _progress += 0.05;
      });

      if (_progress < 1.0) {
        _startLoading();
      } else {
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              '/s2_onboarding',
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _bearController.dispose();
    super.dispose();
  }

  String get loadingText {
    if (_progress < 0.25) {
      return "📖 Đang mở thư viện bài học...";
    } else if (_progress < 0.5) {
      return "🎨 Chuẩn bị hình ảnh...";
    } else if (_progress < 0.75) {
      return "🔊 Tải âm thanh...";
    } else if (_progress < 1.0) {
      return "🚀 Sắp hoàn tất...";
    } else {
      return "🎉 Sẵn sàng học tiếng Anh!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isTablet = screenWidth > 600;

    final double mascotSize =
    isTablet ? 180 : 130;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F2FE),
              Color(0xFFFFFBEB),
              Color(0xFFFDF2F8),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // ⭐ STAR 1
              const Positioned(
                top: 100,
                left: 40,
                child: TwinkleStar(
                  size: 22,
                ),
              ),

              // ⭐ STAR 2
              const Positioned(
                top: 180,
                right: 50,
                child: TwinkleStar(
                  size: 28,
                ),
              ),

              // ⭐ STAR 3
              const Positioned(
                bottom: 240,
                left: 60,
                child: TwinkleStar(
                  size: 18,
                ),
              ),

              // ⭐ STAR 4
              const Positioned(
                bottom: 180,
                right: 80,
                child: TwinkleStar(
                  size: 24,
                ),
              ),

              Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(
                    milliseconds: 1200,
                  ),
                  tween: Tween(
                    begin: 0,
                    end: 1,
                  ),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          40 * (1 - value),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _bearScale,
                        child: Container(
                          width: mascotSize,
                          height: mascotSize,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFEF3C7,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(
                                0xFFFCD34D,
                              ),
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber
                                    .withOpacity(0.35),
                                blurRadius: 30,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "🐻",
                              style: TextStyle(
                                fontSize:
                                isTablet ? 90 : 65,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Text(
                        "BÉ HỌC",
                        style: TextStyle(
                          fontSize:
                          isTablet ? 34 : 26,
                          fontWeight:
                          FontWeight.w900,
                          color: const Color(
                            0xFF0284C7,
                          ),
                          letterSpacing: 3,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFF97316,
                          ),
                          borderRadius:
                          BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: Text(
                          "TIẾNG ANH",
                          style: TextStyle(
                            fontSize:
                            isTablet ? 20 : 14,
                            fontWeight:
                            FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "OFFLINE 100%",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                          FontWeight.bold,
                          color: Color(
                            0xFF10B981,
                          ),
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 60),

                      SizedBox(
                        width:
                        isTablet ? 320 : 240,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 14,
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      30,
                                    ),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration:
                                  const Duration(
                                    milliseconds:
                                    200,
                                  ),
                                  height: 14,
                                  width:
                                  (isTablet
                                      ? 320
                                      : 240) *
                                      _progress,
                                  decoration:
                                  BoxDecoration(
                                    gradient:
                                    const LinearGradient(
                                      colors: [
                                        Color(
                                          0xFF06B6D4,
                                        ),
                                        Color(
                                          0xFF3B82F6,
                                        ),
                                        Color(
                                          0xFF6366F1,
                                        ),
                                      ],
                                    ),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      30,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            Text(
                              "${(_progress * 100).toInt()}%",
                              style:
                              const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                                color: Color(
                                  0xFF0F172A,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              loadingText,
                              textAlign:
                              TextAlign.center,
                              style:
                              TextStyle(
                                fontSize:
                                isTablet
                                    ? 14
                                    : 12,
                                fontWeight:
                                FontWeight
                                    .w600,
                                color:
                                Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class TwinkleStar extends StatefulWidget {
  final double size;

  const TwinkleStar({
    super.key,
    required this.size,
  });

  @override
  State<TwinkleStar> createState() =>
      _TwinkleStarState();
}

class _TwinkleStarState
    extends State<TwinkleStar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.scale(
          scale: 0.8 + (controller.value * 0.5),
          child: Opacity(
            opacity: 0.4 +
                (controller.value * 0.6),
            child: child,
          ),
        );
      },
      child: Text(
        "✨",
        style: TextStyle(
          fontSize: widget.size,
        ),
      ),
    );
  }
}