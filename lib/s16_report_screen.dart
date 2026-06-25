import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: PARENT REPORT
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S16reportScreen extends StatefulWidget {
  const S16reportScreen({super.key});

  @override
  State<S16reportScreen> createState() => _S16reportScreenState();
}

class _S16reportScreenState extends State<S16reportScreen> {
  Widget _buildProgressRow(
    String label,
    double value,
    String text,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildBar(double value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 14,
          height: value,
          decoration: const BoxDecoration(
            color: Color(0xFF6366F1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Color(0xFF94A3B8),
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
                            Navigator.pushNamed(context, '/s3_parent_gate'),
                      ),
                      const Text(
                        'BÁO CÁO TUẦN',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF4F46E5),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Tiến Độ Học Tập Của Bé',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tuần: 01/07 - 07/07',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildProgressRow(
                          'Bảng chữ cái (ABC)',
                          0.8,
                          '80%',
                          const Color(0xFF10B981),
                        ),
                        const SizedBox(height: 10),
                        _buildProgressRow(
                          'Chữ số (Numbers)',
                          0.6,
                          '60%',
                          const Color(0xFF0EA5E9),
                        ),
                        const SizedBox(height: 10),
                        _buildProgressRow(
                          'Động vật (Animals)',
                          0.45,
                          '45%',
                          const Color(0xFFF59E0B),
                        ),
                        const SizedBox(height: 10),
                        _buildProgressRow(
                          'Màu sắc (Colors)',
                          0.3,
                          '30%',
                          const Color(0xFFEF4444),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'THỜI LƯỢNG HỌC HÀNG NGÀY:',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildBar(15, 'T2'),
                                    _buildBar(25, 'T3'),
                                    _buildBar(45, 'T4'),
                                    _buildBar(10, 'T5'),
                                    _buildBar(30, 'T6'),
                                    _buildBar(20, 'T7'),
                                    _buildBar(35, 'CN'),
                                  ],
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
                        'Mở Parent Dashboard ➔',
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
