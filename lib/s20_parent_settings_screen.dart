import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: PARENT SETTINGS
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S20parentsettingsScreen extends StatefulWidget {
  const S20parentsettingsScreen({super.key});

  @override
  State<S20parentsettingsScreen> createState() => _S20parentsettingsState();
}

class _S20parentsettingsState extends State<S20parentsettingsScreen> {
  bool _soundOn = true;
  String _language = 'Tiếng Việt';
  bool _notificationsOn = true;

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
                  // Top Bar
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
                        'CÀI ĐẶT HỆ THỐNG',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 48), // Spacer to balance
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Cấu hình tài khoản phụ huynh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Settings options list
                  Expanded(
                    child: ListView(
                      children: [
                        // Sound setting
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.volume_up_rounded,
                                    color: Color(0xFF6366F1),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Nhạc nền & Phát âm',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                value: _soundOn,
                                activeColor: const Color(0xFF4F46E5),
                                onChanged: (value) {
                                  setState(() {
                                    _soundOn = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Language setting
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.language_rounded,
                                    color: Color(0xFF6366F1),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Ngôn ngữ giao diện',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                _language,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Notification setting
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.notifications_rounded,
                                    color: Color(0xFF6366F1),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Thông báo nhắc nhở',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              Switch(
                                value: _notificationsOn,
                                activeColor: const Color(0xFF4F46E5),
                                onChanged: (value) {
                                  setState(() {
                                    _notificationsOn = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Delete all progress
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Xác nhận xóa',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  content: const Text(
                                    'Bạn có chắc chắn muốn xóa tất cả tiến độ học tập và tích lũy sao của bé không?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Hủy bỏ',
                                        style: TextStyle(
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Đã xóa toàn bộ lịch sử tiến độ thành công!',
                                            ),
                                            backgroundColor: Color(0xFFEF4444),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Đồng ý',
                                        style: TextStyle(
                                          color: Color(0xFFEF4444),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2),
                              border: Border.all(
                                color: const Color(0xFFFEE2E2),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Xóa toàn bộ dữ liệu',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFEF4444),
                                  ),
                                ),
                                Icon(
                                  Icons.delete_forever_rounded,
                                  color: Color(0xFFEF4444),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Paywall button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/s21_subscription_paywall',
                        );
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
                        'Xem Gói Premium (Paywall) ➔',
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
