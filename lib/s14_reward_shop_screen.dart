import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: REWARD SHOP
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S14rewardshopScreen extends StatefulWidget {
  const S14rewardshopScreen({super.key});

  @override
  State<S14rewardshopScreen> createState() => _S14rewardshopScreenState();
}

class _S14rewardshopScreenState extends State<S14rewardshopScreen> {
  int _stars = 120;
  final List<Map<String, dynamic>> _shopItems = [
    {'name': 'Hình nền Động vật', 'price': 30, 'icon': '🦊', 'unlocked': true},
    {'name': 'Sticker Gấu Trúc', 'price': 50, 'icon': '🐼', 'unlocked': false},
    {
      'name': 'Huy hiệu Vương miện',
      'price': 100,
      'icon': '👑',
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
                            Navigator.pushNamed(context, '/s4_home'),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFEF08A)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFEAB308),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '\\$_stars',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFCA8A04),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Đổi Thưởng Cho Bé',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _shopItems.length,
                      itemBuilder: (context, index) {
                        final item = _shopItems[index];
                        final bool unlocked = item['unlocked'];
                        final int price = item['price'];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFF1F5F9),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item['icon'],
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Giá: \\$price ⭐',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: unlocked
                                    ? null
                                    : () {
                                        if (_stars >= price) {
                                          setState(() {
                                            _stars -= price;
                                            _shopItems[index]['unlocked'] =
                                                true;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Đổi quà thành công!',
                                              ),
                                              backgroundColor: Color(
                                                0xFF10B981,
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Không đủ sao rồi bé ơi!',
                                              ),
                                              backgroundColor: Color(
                                                0xFFEF4444,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: unlocked
                                      ? const Color(0xFFF1F5F9)
                                      : const Color(0xFFF59E0B),
                                  foregroundColor: unlocked
                                      ? const Color(0xFF94A3B8)
                                      : Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  unlocked ? 'Đã đổi' : 'Đổi quà',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/s15_multi_child');
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
                        'Xem Hồ Sơ Bé (Multi Child) ➔',
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
