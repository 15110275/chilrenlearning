import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: LESSON
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S6lessonScreen extends StatefulWidget {
  const S6lessonScreen({super.key});

  @override
  State<S6lessonScreen> createState() => _S6lessonScreenState();
}

class _S6lessonScreenState extends State<S6lessonScreen> {

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
              padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thanh trạng thái phía trên bài học
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close),
                        style: IconButton.styleFrom(backgroundColor: Colors.white),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const LinearProgressIndicator(
                              value: 0.25,
                              minHeight: 8,
                              backgroundColor: Color(0xFFE2E8F0),
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                            ),
                          ),
                        ),
                      ),
                      const Text('1/26', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),

                  // Khu vực hiển thị Flashcard trung tâm (Thích ứng Mobile/Tablet)
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 450 : 320,
                    ),
                    height: isTablet ? 380 : 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                      border: Border.all(color: const Color(0xFFEEF2FF), width: 2),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Chữ cái lớn
                        const Text(
                          'A a',
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4F46E5),
                          ),
                        ),
                        // Hình ảnh minh họa lớn ngộ nghĩnh
                        const Text('🍎', style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 8),
                        // Từ vựng kèm phiên âm
                        const Text(
                          'Apple',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                        ),
                        Text(
                          '/ˈæpl/',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500], fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  // Bộ điều khiển âm thanh & Chuyển bài học
                  Column(
                    children: [
                      // Nút phát loa khổng lồ cho trẻ dễ bấm
                      GestureDetector(
                        onTap: () {
                          // Phát âm thanh
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFC7D2FE), width: 4),
                          ),
                          child: const Icon(Icons.volume_up, size: 36, color: Color(0xFF4F46E5)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Quay lại'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey[700],
                              elevation: 0,
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: const Text('Tiếp theo'),
                            icon: const Icon(Icons.arrow_forward),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
