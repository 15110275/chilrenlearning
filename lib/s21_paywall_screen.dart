import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: SUBSCRIPTION PAYWALL
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S21paywallScreen extends StatefulWidget {
  const S21paywallScreen({super.key});

  @override
  State<S21paywallScreen> createState() => _S21paywallScreenState();
}

class _S21paywallScreenState extends State<S21paywallScreen> {
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/s4_home'),
                        child: const Text(
                          '✕ Đóng',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                    child: Column(
                      children: [
                        Text('💎', style: TextStyle(fontSize: 32)),
                        SizedBox(height: 6),
                        Text(
                          'NÂNG CẤP PREMIUM',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4338CA),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Mở khóa thế giới học tiếng Anh vui nhộn',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E7FF)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ƯU ĐÃI ĐẶC QUYỀN:',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF3730A3),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '✨ Không chứa bất kì quảng cáo nào',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '✨ Mở khóa tất cả 76+ bài học & 20+ chủ đề',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '✨ Xem báo cáo & phân tích chuyên sâu cho bố mẹ',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF475569),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '✨ Đồng bộ không giới hạn số lượng hồ sơ bé',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFF6366F1),
                              width: 2,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gói 1 Năm',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Tự động gia hạn hàng năm',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '149.000đ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4F46E5),
                                    ),
                                  ),
                                  Text(
                                    '348.000đ',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF94A3B8),
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gói 1 Tháng',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Thanh toán theo tháng',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '29.000đ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Đăng ký dùng thử thành công gói 7 ngày!',
                            ),
                            backgroundColor: Color(0xFF10B981),
                          ),
                        );
                        Navigator.pushNamed(context, '/s4_home');
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
                        'Dùng thử 7 ngày miễn phí! ➔',
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
