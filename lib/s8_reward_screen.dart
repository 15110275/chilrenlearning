import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: REWARD
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S8rewardScreen extends StatefulWidget {
  const S8rewardScreen({super.key});

  @override
  State<S8rewardScreen> createState() => _S8rewardScreenState();
}

class _S8rewardScreenState extends State<S8rewardScreen> {
  double _scale = 1.0;

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
            return Padding(
              padding: EdgeInsets.all(isTablet ? 32.0 : 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      // Star illustration with pulse effect simulation
                      Container(
                        width: isTablet ? 120 : 96,
                        height: isTablet ? 120 : 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF08A),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFDE047).withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: const Center(
                          child: Text('⭐', style: TextStyle(fontSize: 48)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'TUYỆT VỜI!',
                        style: TextStyle(
                          fontSize: 24,
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
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFFFEF08A),
                            width: 2,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded, color: Color(0xFFEAB308)),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/s9_daily_mission');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5E9),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Tiếp tục học ➔',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
