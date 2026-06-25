import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: MULTI CHILD
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S15multichildScreen extends StatefulWidget {
  const S15multichildScreen({super.key});

  @override
  State<S15multichildScreen> createState() => _S15multichildScreenState();
}

class _S15multichildScreenState extends State<S15multichildScreen> {
  String _activeProfileId = '1';
  final List<Map<String, dynamic>> _profiles = [
    {
      'id': '1',
      'name': 'Bin Bin',
      'age': 4,
      'avatar': '🦊',
      'level': 2,
      'stars': 120,
    },
    {
      'id': '2',
      'name': 'Bông Bông',
      'age': 5,
      'avatar': '🐷',
      'level': 1,
      'stars': 45,
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
                            Navigator.pushNamed(context, '/s14_reward_shop'),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E8FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Tính năng Premium',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7E22CE),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Quản lý tài khoản bé',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        ..._profiles.map((p) {
                          final bool isActive = _activeProfileId == p['id'];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFEEF2FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isActive
                                    ? const Color(0xFF818CF8)
                                    : const Color(0xFFF1F5F9),
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  _activeProfileId = p['id'];
                                });
                              },
                              leading: Text(
                                p['avatar'],
                                style: const TextStyle(fontSize: 32),
                              ),
                              title: Text(
                                p['name'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              subtitle: Text(
                                '${p['age']} tuổi • Level ${p['level']}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    p['stars'].toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFF59E0B),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFF59E0B),
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Vui lòng nâng cấp Premium để thêm nhiều bé học tập!',
                                ),
                                backgroundColor: Color(0xFF7E22CE),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFCBD5E1),
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: Color(0xFF64748B),
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Thêm hồ sơ mới',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/s16_parent_report');
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
                        'Xem Báo Cáo Tuần (Parent Report) ➔',
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
