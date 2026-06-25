import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: QUIZ RESULT
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S13quizresultScreen extends StatefulWidget {
  const S13quizresultScreen({super.key});

  @override
  State<S13quizresultScreen> createState() => _S13quizresultScreenState();
}

class _S13quizresultScreenState extends State<S13quizresultScreen> {
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
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E7FF),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFC7D2FE),
                            width: 4,
                          ),
                        ),
                        child: const Center(
                          child: Text('📊', style: TextStyle(fontSize: 36)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'KẾT QUẢ QUIZ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4338CA),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Luyện tập: Alphabet & Chữ số',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '8 / 10',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFBEB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFFEF3C7),
                              ),
                            ),
                            child: const Text(
                              '+10 Stars',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA8A04),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE0E7FF),
                              ),
                            ),
                            child: const Text(
                              '+1 Badge Progress',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4F46E5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/s14_reward_shop');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Nhận sao & Đổi quà ➔',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/s7_quiz');
                          },
                          icon: const Icon(
                            Icons.refresh_rounded,
                            size: 16,
                            color: Color(0xFF64748B),
                          ),
                          label: const Text(
                            'Làm lại Quiz',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ],
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
