import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: GOAL SETTING
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S18goalsettingScreen extends StatefulWidget {
  const S18goalsettingScreen({super.key});

  @override
  State<S18goalsettingScreen> createState() => _S18goalsettingState();
}

class _S18goalsettingState extends State<S18goalsettingScreen> {
  int _lessons = 5;
  int _minutes = 15;
  bool _alarm = true;

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
                  // Header Back Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF64748B),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'MỤC TIÊU HỌC TẬP',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF64748B),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 48), // Spacer to balance
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Cài đặt mục tiêu cho bé',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Goal adjustments list
                  Expanded(
                    child: ListView(
                      children: [
                        // Lessons Adjuster
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SỐ BÀI HỌC / NGÀY',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline_rounded,
                                      size: 28,
                                      color: Color(0xFF4F46E5),
                                    ),
                                    onPressed: () {
                                      if (_lessons > 1) {
                                        setState(() {
                                          _lessons--;
                                        });
                                      }
                                    },
                                  ),
                                  Text(
                                    '$_lessons bài',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 28,
                                      color: Color(0xFF4F46E5),
                                    ),
                                    onPressed: () {
                                      if (_lessons < 20) {
                                        setState(() {
                                          _lessons++;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Minutes Adjuster
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'THỜI GIAN HỌC / NGÀY',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline_rounded,
                                      size: 28,
                                      color: Color(0xFF4F46E5),
                                    ),
                                    onPressed: () {
                                      if (_minutes > 5) {
                                        setState(() {
                                          _minutes -= 5;
                                        });
                                      }
                                    },
                                  ),
                                  Text(
                                    '$_minutes Phút',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 28,
                                      color: Color(0xFF4F46E5),
                                    ),
                                    onPressed: () {
                                      if (_minutes < 120) {
                                        setState(() {
                                          _minutes += 5;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Alarm toggle
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'BÁO NHẮC NHỞ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Giờ nhắc: 18:00 hàng ngày',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                value: _alarm,
                                activeColor: const Color(0xFF4F46E5),
                                onChanged: (value) {
                                  setState(() {
                                    _alarm = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Đã lưu mục tiêu học tập thành công!',
                            ),
                            backgroundColor: Color(0xFF10B981),
                          ),
                        );
                        Navigator.pushNamed(context, '/s17_parent_dashboard');
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
                        'Lưu mục tiêu học tập ➔',
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
