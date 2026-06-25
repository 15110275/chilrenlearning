import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: BADGES
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S11badgesScreen extends StatefulWidget {
  const S11badgesScreen({super.key});

  @override
  State<S11badgesScreen> createState() => _S11badgesScreenState();
}

class _S11badgesScreenState extends State<S11badgesScreen> {
  final List<Map<String, dynamic>> _badges = [
    {
      'title': 'Nhà thông thái',
      'requirement': 'Học xong 5 bài học',
      'icon': '🎓',
      'unlocked': true,
    },
    {
      'title': 'Chăm chỉ',
      'requirement': 'Giữ chuỗi học 5 ngày',
      'icon': '⚡',
      'unlocked': true,
    },
    {
      'title': 'Siêu sao tiếng Anh',
      'requirement': 'Đạt điểm tối đa Quiz',
      'icon': '🏅',
      'unlocked': false,
    },
  ];

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
                            Navigator.pushNamed(context, '/s10_streak'),
                      ),
                      const Text(
                        'HUY HIỆU CỦA BÉ',
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
                    'Thành tích đã tích lũy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _badges.length,
                      itemBuilder: (context, index) {
                        final badge = _badges[index];
                        final bool unlocked = badge['unlocked'];
                        return Opacity(
                          opacity: unlocked ? 1.0 : 0.6,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: unlocked
                                    ? const Color(0xFFC7D2FE)
                                    : const Color(0xFFE2E8F0),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: unlocked
                                        ? const Color(0xFFEEF2FF)
                                        : const Color(0xFFF1F5F9),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: unlocked
                                          ? const Color(0xFF818CF8)
                                          : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      badge['icon'],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            badge['title'],
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: unlocked
                                                  ? const Color(0xFFEEF2FF)
                                                  : const Color(0xFFF1F5F9),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              unlocked ? 'Đã đạt' : 'Chưa đạt',
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: unlocked
                                                    ? const Color(0xFF4F46E5)
                                                    : const Color(0xFF64748B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        badge['requirement'],
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/s12_learning_map');
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
                        'Xem bản đồ học tập ➔',
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
