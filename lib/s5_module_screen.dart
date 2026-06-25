import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: MODULE
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S5moduleScreen extends StatefulWidget {
  const S5moduleScreen({super.key});

  @override
  State<S5moduleScreen> createState() => _S5moduleScreenState();
}

class _S5moduleScreenState extends State<S5moduleScreen> {
  final List<String> _letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
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
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Học bảng chữ cái (2/26)',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0369A1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Alphabet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.0,
                          ),
                      itemCount: _letters.length,
                      itemBuilder: (context, index) {
                        final String letter = _letters[index];
                        final bool learned = index < 2;
                        return InkWell(
                          onTap: () {
                            if (letter == 'A' ||
                                letter == 'B' ||
                                letter == 'C') {
                              Navigator.pushNamed(context, '/s6_lesson');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Hãy học chữ cái \\${letter} nhé!',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: learned
                                  ? const Color(0xFFECFDF5)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: learned
                                    ? const Color(0xFFA7F3D0)
                                    : const Color(0xFFE2E8F0),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  letter,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: learned
                                        ? const Color(0xFF059669)
                                        : const Color(0xFF334155),
                                  ),
                                ),
                                if (learned) ...[
                                  const SizedBox(height: 2),
                                  const Text(
                                    'ĐÃ HỌC',
                                    style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF10B981),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/s6_lesson');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Tiếp tục học ➔',
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
