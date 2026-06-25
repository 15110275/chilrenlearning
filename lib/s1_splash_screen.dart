import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: SPLASH
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S1splashScreen extends StatefulWidget {
  const S1splashScreen({super.key});

  @override
  State<S1splashScreen> createState() => _S1splashScreenState();
}

class _S1splashScreenState extends State<S1splashScreen> {

  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _progress += 0.05;
        });
        if (_progress < 1.0) {
          _startLoading();
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushReplacementNamed(context, '/s2_onboarding');
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Xác định thiết bị bằng Width (Tablet > 600)
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD), // Màu nền canvas nhẹ
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Layout thích ứng động dựa trên kích thước khung màn hình của Android Studio
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Mascot hình gấu trúc siêu dễ thương
                  Container(
                    width: isTablet ? 180 : 120,
                    height: isTablet ? 180 : 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFCD34D), width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '🐻',
                        style: TextStyle(fontSize: isTablet ? 90 : 60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tiêu đề thương hiệu
                  Text(
                    'BÉ HỌC',
                    style: TextStyle(
                      fontSize: isTablet ? 32 : 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0284C7),
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'TIẾNG ANH',
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'OFFLINE 100%',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF10B981),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Thanh tiến trình loading bar sinh động
                  SizedBox(
                    width: isTablet ? 300 : 200,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progress,
                            minHeight: 10,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0EA5E9)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _progress < 1.0
                              ? 'Đang tải dữ liệu offline ${(_progress * 100).toInt()}%...'
                              : 'Tải hoàn tất! Sẵn sàng học.',
                          style: TextStyle(
                            fontSize: isTablet ? 14 : 11,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
