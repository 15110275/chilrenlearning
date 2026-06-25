import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: LEARNING MAP
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S12mapScreen extends StatefulWidget {
  const S12mapScreen({super.key});

  @override
  State<S12mapScreen> createState() => _S12mapScreenState();
}

class _S12mapScreenState extends State<S12mapScreen> {
  Widget _buildMapNode(
    String label,
    String status,
    Color color, {
    bool active = false,
    bool locked = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (!locked) {
              Navigator.pushNamed(context, '/s6_lesson');
            }
          },
          child: Container(
            width: active ? 54 : 48,
            height: active ? 54 : 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: active ? 4 : 2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: locked
                  ? const Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                      size: 16,
                    )
                  : Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w800,
            color: active ? const Color(0xFF0EA5E9) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
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
            return Padding(
              padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF64748B),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/s4_home'),
                      ),
                      const Text(
                        'BẢN ĐỒ HỌC TẬP',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Alphabet Road Map',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE0E7FF)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            color: const Color(0xFFC7D2FE),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMapNode(
                                'A',
                                'Xong',
                                const Color(0xFF10B981),
                              ),
                              _buildMapNode(
                                'B',
                                'Xong',
                                const Color(0xFF10B981),
                              ),
                              _buildMapNode(
                                'C',
                                'Đang học',
                                const Color(0xFF0EA5E9),
                                active: true,
                              ),
                              _buildMapNode(
                                'D',
                                'Khóa',
                                const Color(0xFF94A3B8),
                                locked: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/s13_quiz_result');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Xem Kết quả ôn tập (Quiz Result) ➔',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
