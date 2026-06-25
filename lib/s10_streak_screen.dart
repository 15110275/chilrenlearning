import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: STREAK
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S10streakScreen extends StatefulWidget {
  const S10streakScreen({super.key});

  @override
  State<S10streakScreen> createState() => _S10streakScreenState();
}

class _S10streakScreenState extends State<S10streakScreen> {
  Widget _buildDayItem(String day, bool active) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: active ? const Color(0xFFF97316) : const Color(0xFFF8FAFC),
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? const Color(0xFFFB923C) : const Color(0xFFE2E8F0),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              active ? '🔥' : '💤',
              style: const TextStyle(fontSize: 12),
            ),
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
                            Navigator.pushNamed(context, '/s9_daily_mission'),
                      ),
                      const Text(
                        'CHUỖI HỌC TẬP',
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
                  const SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEDD5),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFDBA74),
                              width: 4,
                            ),
                          ),
                          child: const Center(
                            child: Text('🔥', style: TextStyle(fontSize: 40)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '6 ngày liên tiếp',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFF97316),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Giữ chuỗi học tập hàng ngày để rinh ngay phần thưởng lớn cuối tuần nhé!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFF1F5F9),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDayItem('T2', true),
                        _buildDayItem('T3', true),
                        _buildDayItem('T4', true),
                        _buildDayItem('T5', true),
                        _buildDayItem('T6', true),
                        _buildDayItem('T7', true),
                        _buildDayItem('CN', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'MỐC THƯỞNG TIẾP THEO:',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '7 ngày',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF334155),
                                ),
                              ),
                              Text(
                                '+50 Stars',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '30 ngày',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F46E5),
                                ),
                              ),
                              Text(
                                'Huy hiệu Vàng',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/s11_badges');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Xem bộ Huy hiệu ➔',
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
