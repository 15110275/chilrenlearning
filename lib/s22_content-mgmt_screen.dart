import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: CONTENT MANAGEMENT (FUTURE)
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S22contentmgmtScreen extends StatefulWidget {
  const S22contentmgmtScreen({super.key});

  @override
  State<S22contentmgmtScreen> createState() => _S22contentmgmtScreenState();
}

class _S22contentmgmtScreenState extends State<S22contentmgmtScreen> {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.rocket_launch,
                    size: 60,
                    color: Color(0xFF4F46E5),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'CONTENT MANAGEMENT (FUTURE)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFC7D2FE)),
                    ),
                    child: Text(
                      'Đây là màn hình thuộc nhóm tính năng thiết kế cho sản phẩm di động & máy tính bảng. Flutter hỗ trợ đầy đủ Layout thích ứng.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 14 : 12,
                        color: const Color(0xFF3730A3),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Kích Hoạt Tương Tác'),
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
