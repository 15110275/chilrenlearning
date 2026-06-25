import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: LESSON
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S6lessonScreen extends StatefulWidget {
  const S6lessonScreen({super.key});

  @override
  State<S6lessonScreen> createState() => _S6lessonScreenState();
}

class _S6lessonScreenState extends State<S6lessonScreen> {
  int _currentLessonIndex = 0;
  final List<Map<String, dynamic>> _lessons = [
    {
      'letter': 'A',
      'word': 'Apple',
      'phonetic': '/ˈæpl/',
      'translation': 'Quả táo',
      'image': '🍎',
      'color': const Color(0xFFF43F5E),
    },
    {
      'letter': 'B',
      'word': 'Banana',
      'phonetic': '/bəˈnɑːnə/',
      'translation': 'Quả chuối',
      'image': '🍌',
      'color': const Color(0xFFEAB308),
    },
    {
      'letter': 'C',
      'word': 'Cat',
      'phonetic': '/kæt/',
      'translation': 'Con mèo',
      'image': '🐱',
      'color': const Color(0xFFF97316),
    },
    {
      'letter': 'D',
      'word': 'Dog',
      'phonetic': '/dɒɡ/',
      'translation': 'Con chó',
      'image': '🐶',
      'color': const Color(0xFF6366F1),
    },
    {
      'letter': 'E',
      'word': 'Elephant',
      'phonetic': '/ˈelɪfənt/',
      'translation': 'Con voi',
      'image': '🐘',
      'color': const Color(0xFF8B5CF6),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thanh trạng thái phía trên bài học (giống PhoneSimulator.tsx)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/s5_module'),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Color(0xFF64748B),
                          size: 16,
                        ),
                        label: const Text(
                          'Danh sách',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      ),
                      Text(
                        'Bài ${_currentLessonIndex + 1}/${_lessons.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF94A3B8),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),

                  // Khu vực hiển thị Flashcard trung tâm
                  Expanded(
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: isTablet ? 450 : 320,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                            width: 4,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Chữ cái lớn
                            Text(
                              _lessons[_currentLessonIndex]['letter']!,
                              style: const TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E293B),
                              ),
                            ),

                            // Hình ảnh minh họa với màu nền gradient theo từng từ
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    _lessons[_currentLessonIndex]['color']!
                                        .withOpacity(0.7),
                                    _lessons[_currentLessonIndex]['color']!,
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _lessons[_currentLessonIndex]['image']!,
                                style: const TextStyle(fontSize: 56),
                              ),
                            ),

                            // Từ vựng, phiên âm và nghĩa tiếng Việt
                            Column(
                              children: [
                                Text(
                                  _lessons[_currentLessonIndex]['word']!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _lessons[_currentLessonIndex]['phonetic']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '(${_lessons[_currentLessonIndex]['translation']!})',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4F46E5),
                                  ),
                                ),
                              ],
                            ),

                            // Nút Nghe phát âm
                            ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '🔊 Đang phát âm từ: ${_lessons[_currentLessonIndex]['word']!}',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.volume_up, size: 14),
                              label: const Text(
                                'Nghe phát âm',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4F46E5),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 11,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bộ chuyển đổi trước / sau bài học
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _currentLessonIndex == 0
                              ? null
                              : () {
                                  setState(() {
                                    _currentLessonIndex--;
                                  });
                                },
                          icon: const Icon(Icons.chevron_left, size: 16),
                          label: const Text(
                            'Trước',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF1F5F9),
                            foregroundColor: const Color(0xFF334155),
                            disabledBackgroundColor: const Color(
                              0xFFF1F5F9,
                            ).withOpacity(0.4),
                            disabledForegroundColor: const Color(
                              0xFF334155,
                            ).withOpacity(0.4),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_currentLessonIndex < _lessons.length - 1) {
                              setState(() {
                                _currentLessonIndex++;
                              });
                            } else {
                              Navigator.pushNamed(context, '/s7_quiz');
                            }
                          },
                          label: Text(
                            _currentLessonIndex == _lessons.length - 1
                                ? 'Làm Quiz! ➔'
                                : 'Tiếp theo',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            _currentLessonIndex == _lessons.length - 1
                                ? Icons.assignment_turned_in
                                : Icons.chevron_right,
                            size: 16,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
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
