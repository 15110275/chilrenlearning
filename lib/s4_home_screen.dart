import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: HOME
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S4homeScreen extends StatefulWidget {
  const S4homeScreen({super.key});

  @override
  State<S4homeScreen> createState() => _S4homeScreenState();
}

class _S4homeScreenState extends State<S4homeScreen> {
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
                  // Top Stats bar matching PhoneSimulator.tsx
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('🦁', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bin Bin',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const Text(
                                  'Level 2',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF59E0B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFFEF3C7)),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 14,
                                color: Color(0xFFF59E0B),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '120',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Goal Progress display matching PhoneSimulator.tsx
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '🎯 Hôm nay: Học 5 bài',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475569),
                              ),
                            ),
                            Text(
                              '2/5',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const LinearProgressIndicator(
                            value: 0.4,
                            minHeight: 6,
                            backgroundColor: Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFFF97316),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CHỌN CHỦ ĐỀ HỌC
                  const Text(
                    'CHỌN CHỦ ĐỀ HỌC:',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Grid with 4 subjects matching PhoneSimulator.tsx
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: isTablet ? 3 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.1,
                      children: [
                        _buildCategoryCard(
                          context,
                          'ABC',
                          'Bảng chữ cái',
                          '90% Học',
                          const Color(0xFFE0F2FE),
                          const Color(0xFF0284C7),
                          const Color(0xFFF0F9FF),
                          const Color(0xFF0369A1),
                        ),
                        _buildCategoryCard(
                          context,
                          '123',
                          'Chữ số',
                          '60% Học',
                          const Color(0xFFFEF3C7),
                          const Color(0xFFD97706),
                          const Color(0xFFFFFBEB),
                          const Color(0xFFB45309),
                        ),
                        _buildCategoryCard(
                          context,
                          '🦁',
                          'Động vật',
                          '70% Học',
                          const Color(0xFFD1FAE5),
                          const Color(0xFF059669),
                          const Color(0xFFECFDF5),
                          const Color(0xFF047857),
                        ),
                        _buildCategoryCard(
                          context,
                          '🎨',
                          'Màu sắc',
                          'Hoàn tất',
                          const Color(0xFFFCE7F3),
                          const Color(0xFFDB2777),
                          const Color(0xFFFDF2F8),
                          const Color(0xFFBE185D),
                        ),
                      ],
                    ),
                  ),

                  // Navigation bar at bottom matching PhoneSimulator.tsx
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🏠', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 2),
                              Text(
                                'Trang chủ',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0EA5E9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/s14_reward_shop'),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🎁', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 2),
                              Text(
                                'Phần thưởng',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/s3_parent_gate'),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🔒', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 2),
                              Text(
                                'Phụ huynh',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildCategoryCard(
    BuildContext context,
    String displayVal,
    String title,
    String badgeText,
    Color borderColor,
    Color textColor,
    Color badgeBg,
    Color badgeTextCol,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/s5_module'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 2),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayVal,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: badgeTextCol,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
