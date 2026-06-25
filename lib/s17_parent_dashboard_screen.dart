import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: PARENT DASHBOARD
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S17parentdashboardScreen extends StatefulWidget {
  const S17parentdashboardScreen({super.key});

  @override
  State<S17parentdashboardScreen> createState() => _S17parentdashboardState();
}

class _S17parentdashboardState extends State<S17parentdashboardScreen> {
  int _activeTab = 0; // 0: Trang chủ, 1: Báo cáo, 2: Cài đặt

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
                  // Parent profile stats header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFEFF6FF),
                              child: Text('🦁', style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bé Minh',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Level 2 • 4 Tuổi',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFD97706),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '120 Sao',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: isTablet ? 14 : 11,
                                  color: const Color(0xFFD97706),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Summary metrics list
                  Expanded(
                    child: ListView(
                      children: [
                        _buildMetricTile(
                          icon: Icons.timer_outlined,
                          title: 'GIỜ HỌC HÔM NAY',
                          value: '15 Phút',
                          color: const Color(0xFF4F46E5),
                          bgColor: const Color(0xFFEEF2FF),
                        ),
                        _buildMetricTile(
                          icon: Icons.check_circle_outline_rounded,
                          title: 'TIẾN TRÌNH ĐÃ HỌC',
                          value: '46 / 76 Bài học',
                          color: const Color(0xFF10B981),
                          bgColor: const Color(0xFFECFDF5),
                        ),
                        _buildMetricTile(
                          icon: Icons.local_fire_department_rounded,
                          title: 'CHUỖI HỌC LIÊN TỤC',
                          value: '6 Ngày',
                          color: const Color(0xFFF97316),
                          bgColor: const Color(0xFFFFF7ED),
                        ),
                        const SizedBox(height: 16),

                        // Shortcuts to deep settings
                        const Text(
                          'CẤU HÌNH NHANH',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF64748B),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _buildShortcutButton(
                                icon: Icons.playlist_add_check_rounded,
                                title: 'Mục Tiêu Học',
                                subtitle: '5 bài / 15 phút',
                                color: const Color(0xFF6366F1),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/s18_goal_setting',
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildShortcutButton(
                                icon: Icons.screen_lock_portrait_rounded,
                                title: 'Hạn Thời Gian',
                                subtitle: '30 phút sử dụng',
                                color: const Color(0xFFEC4899),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/s19_screen_time',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom bar simulation
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBottomNavItem(
                          0,
                          Icons.home_rounded,
                          'Trang chủ',
                          () {
                            Navigator.pushNamed(context, '/s4_home');
                          },
                        ),
                        _buildBottomNavItem(
                          1,
                          Icons.bar_chart_rounded,
                          'Báo cáo',
                          () {
                            Navigator.pushNamed(context, '/s16_parent_report');
                          },
                        ),
                        _buildBottomNavItem(
                          2,
                          Icons.settings_rounded,
                          'Cài đặt',
                          () {
                            Navigator.pushNamed(
                              context,
                              '/s20_parent_settings',
                            );
                          },
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

  Widget _buildMetricTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFF94A3B8),
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildShortcutButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border.all(color: color.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    int index,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    final bool isSelected =
        index == 0; // Default highlight home inside simulation
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? const Color(0xFF4F46E5)
                : const Color(0xFF94A3B8),
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? const Color(0xFF4F46E5)
                  : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
