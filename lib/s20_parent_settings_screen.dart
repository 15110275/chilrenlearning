import 'package:flutter/material.dart';

/// Flutter Widget - PARENT SETTINGS (SIMPLE KID-FRIENDLY VERSION)
/// UI sinh động nhưng không animation phức tạp
/// Responsive cho Mobile & Tablet

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: SafeArea(
        child: Column(
          children: [
            // ============= HEADER =============
            Container(
              padding: EdgeInsets.all(isTablet ? 20.0 : 16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Text(
                    '⚙️ CÀI ĐẶT HỆ THỐNG',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.8,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            // ============= SCROLLABLE CONTENT =============
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        '👨‍👩‍👧 Cấu hình tài khoản phụ huynh',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sound Setting
                      _buildSettingItem(
                        emoji: '🔊',
                        title: 'Nhạc nền & Phát âm',
                        subtitle: 'Bật/tắt âm thanh học tập',
                        color: const Color(0xFF6366F1),
                        bgGradient: [
                          const Color(0xFFEEF2FF),
                          const Color(0xFFDDD6FE),
                        ],
                        trailing: Switch(
                          value: _soundOn,
                          activeColor: const Color(0xFF10B981),
                          inactiveTrackColor: Colors.grey[200],
                          onChanged: (value) {
                            setState(() {
                              _soundOn = value;
                            });
                          },
                        ),
                      ),

                      // Language Setting
                      InkWell(
                        onTap: () {
                          _showLanguageDialog();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: _buildSettingItem(
                          emoji: '🌍',
                          title: 'Ngôn ngữ giao diện',
                          subtitle: 'Chọn ngôn ngữ hiển thị',
                          color: const Color(0xFFC084FC),
                          bgGradient: [
                            const Color(0xFFF3E8FF),
                            const Color(0xFFE9D5FF),
                          ],
                          trailing: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC084FC)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  _language,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFFC084FC),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFFC084FC),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Notification Setting
                      _buildSettingItem(
                        emoji: '🔔',
                        title: 'Thông báo nhắc nhở',
                        subtitle: 'Nhận thông báo từ ứng dụng',
                        color: const Color(0xFFF97316),
                        bgGradient: [
                          const Color(0xFFFFF7ED),
                          const Color(0xFFFFDC82),
                        ],
                        trailing: Switch(
                          value: _notificationsOn,
                          activeColor: const Color(0xFF10B981),
                          inactiveTrackColor: Colors.grey[200],
                          onChanged: (value) {
                            setState(() {
                              _notificationsOn = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Delete Data - Danger Zone
                      InkWell(
                        onTap: () {
                          _showDeleteConfirmDialog();
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFEE2E2),
                                const Color(0xFFFECACA),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: const Color(0xFFEF4444).withOpacity(0.3),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFEF4444)
                                    .withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text('🗑️',
                                      style:
                                      TextStyle(fontSize: 24)),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Xóa toàn bộ dữ liệu',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFEF4444),
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0xFFEF4444),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Premium Button
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: const Color(0xFF4F46E5)
                                .withOpacity(0.4),
                          ),
                          child: const Text(
                            '👑 Xem Gói Premium (Paywall) ➔',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required List<Color> bgGradient,
    required Widget trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text(
            '🌍 Chọn Ngôn Ngữ',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xFF0F172A),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('🇻🇳 Tiếng Việt'),
              const SizedBox(height: 8),
              _buildLanguageOption('🇬🇧 English'),
              const SizedBox(height: 8),
              _buildLanguageOption('🇨🇳 中文'),
              const SizedBox(height: 8),
              _buildLanguageOption('🇯🇵 日本語'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    final cleanLang =
    language.replaceAll(RegExp(r'^[^A-Za-z]*'), '');
    return InkWell(
      onTap: () {
        setState(() {
          _language = cleanLang;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Text(language,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
            const Spacer(),
            if (_language == cleanLang)
              const Icon(Icons.check_circle,
                  color: Color(0xFF10B981)),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text(
            '⚠️ Xác nhận xóa',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xFFEF4444),
            ),
          ),
          content: const Text(
            'Bạn có chắc chắn muốn xóa tất cả tiến độ học tập và tích lũy sao của bé không?\n\nHành động này không thể hoàn tác!',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Hủy',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        '✅ Đã xóa toàn bộ lịch sử tiến độ thành công!'),
                    backgroundColor: Color(0xFF10B981),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: const Text(
                'Đồng ý xóa',
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}