import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: ONBOARDING
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S2onboardingScreen extends StatefulWidget {
  const S2onboardingScreen({super.key});

  @override
  State<S2onboardingScreen> createState() => _S2onboardingScreenState();
}

class _S2onboardingScreenState extends State<S2onboardingScreen> {

  int _currentIndex = 0;
  final List<Map<String, String>> _slides = [
    {
      'emoji': '🎒',
      'title': 'Học Tập Vui Vẻ',
      'subtitle': 'HỌC QUA HÌNH ẢNH SINH ĐỘNG',
      'desc': 'Bảng chữ cái, chữ số và con vật được thiết kế bắt mắt, kích thích tối đa trí tưởng tượng và tư duy cho bé.',
    },
    {
      'emoji': '🔊',
      'title': 'Phát Âm Bản Xứ',
      'subtitle': 'CHUẨN GIỌNG PHÁT ÂM ANH - MỸ',
      'desc': 'Hệ thống âm thanh ngoại tuyến giọng chuẩn bản ngữ, giúp trẻ bắt chước phát âm chính xác từ nhỏ.',
    },
    {
      'emoji': '📡',
      'title': 'Offline An Toàn',
      'subtitle': 'KHÔNG CẦN WIFI - KHÔNG QUẢNG CÁO',
      'desc': 'Trải nghiệm học tập an toàn tuyệt đối, không lo bé bấm nhầm quảng cáo độc hại hay tự mua hàng.',
    }
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
              padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Bỏ qua ➔', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  // Nội dung slide onboarding
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _slides[_currentIndex]['emoji']!,
                          style: TextStyle(fontSize: isTablet ? 120 : 80),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _slides[_currentIndex]['title']!,
                          style: TextStyle(
                            fontSize: isTablet ? 28 : 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _slides[_currentIndex]['subtitle']!,
                          style: TextStyle(
                            fontSize: isTablet ? 14 : 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF4F46E5),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: Text(
                            _slides[_currentIndex]['desc']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 13,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Điều khiển phân trang & Button
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_slides.length, (index) =>
                            GestureDetector(
                              onTap: () => setState(() => _currentIndex = index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                height: 8,
                                width: _currentIndex == index ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index ? const Color(0xFF0EA5E9) : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentIndex < _slides.length - 1) {
                              setState(() => _currentIndex++);
                            } else {
                              Navigator.pushReplacementNamed(context, '/s3_parent_gate');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0EA5E9),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            _currentIndex < _slides.length - 1 ? 'Tiếp Theo' : 'Bắt Đầu Ngay!',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
