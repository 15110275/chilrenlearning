import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: QUIZ
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S7quizScreen extends StatefulWidget {
  const S7quizScreen({super.key});

  @override
  State<S7quizScreen> createState() => _S7quizScreenState();
}

class _S7quizScreenState extends State<S7quizScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Câu hỏi khảo sát
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'CÂU HỎI 3/10',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                              fontSize: 11,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              '⭐ +5',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Đâu là quả "Apple" hả bé?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),

                  // 4 phương án hình ảnh trực quan (Responsive grid)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                        children: [
                          _buildQuizOption('🍌', 'Banana', false, context),
                          _buildQuizOption(
                            '🍎',
                            'Apple',
                            true,
                            context,
                          ), // Đúng
                          _buildQuizOption('🍉', 'Watermelon', false, context),
                          _buildQuizOption('🍇', 'Grape', false, context),
                        ],
                      ),
                    ),
                  ),

                  // Gợi ý nhỏ
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Bé hãy bấm vào hình ảnh đúng nhé! 🐼',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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

  Widget _buildQuizOption(
    String emoji,
    String text,
    bool isCorrect,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: isCorrect ? const Color(0xFF10B981) : Colors.red,
            content: Text(
              isCorrect
                  ? 'Tuyệt vời ba mẹ ơi! Bé chọn ĐÚNG rồi! 🎉'
                  : 'Sai rồi bé ơi, thử lại nhé! 🐻',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
        if (isCorrect) {
          Navigator.pushNamed(context, '/s8_reward');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
