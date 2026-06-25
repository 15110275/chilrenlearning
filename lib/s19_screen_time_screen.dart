import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: 19 SCREEN TIME CONTROL SCREEN
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S19screentimeScreen extends StatefulWidget {
  const S19screentimeScreen({super.key});

  @override
  State<S19screentimeScreen> createState() => _S19screentimeState();
}

class _S19screentimeState extends State<S19screentimeScreen> {
  double _screenTime = 30.0;
  bool _eyesightProtection = true;

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
                          Navigator.pushNamed(context, '/s17_parent_dashboard');
                        },
                      ),
                      const Text(
                        'HẠN THỜI GIAN',
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
                    'Giới hạn thời gian sử dụng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Limit Time display
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '${_screenTime.toInt()} phút',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4F46E5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Hạn định dùng tối đa mỗi ngày cho bé',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Slider
                  Slider(
                    value: _screenTime,
                    min: 10,
                    max: 120,
                    divisions: 22,
                    label: '${_screenTime.toInt()}m',
                    activeColor: const Color(0xFF4F46E5),
                    inactiveColor: const Color(0xFFE2E8F0),
                    onChanged: (double value) {
                      setState(() {
                        _screenTime = value;
                      });
                    },
                  ),

                  // Time marks
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '10m',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          '30m',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          '60m',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          '90m',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          '120m',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Eyesight info card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      border: Border.all(color: const Color(0xFFFCD34D)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.visibility_rounded,
                              color: Color(0xFFD97706),
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '✓ Bảo vệ mắt bé:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Tự động khóa màn hình khi dùng quá hạn định giúp ngừa cận thị ở trẻ nhỏ học sớm.',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF92400E),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Protection toggle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Kích Hoạt Bảo Vệ Mắt',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Switch(
                          value: _eyesightProtection,
                          activeColor: const Color(0xFF4F46E5),
                          onChanged: (value) {
                            setState(() {
                              _eyesightProtection = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Đã kích hoạt bảo vệ mắt thành công!',
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
                        'Lưu cấu hình thời gian ➔',
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
