import 'package:flutter/material.dart';

/// Flutter Widget mô phỏng màn hình: PARENT GATE
/// Hỗ trợ responsive toàn diện cho cả thiết bị di động (Mobile) và Máy tính bảng (Tablet)
/// Phục vụ hiển thị trên Android Studio IDE & ứng dụng đa nền tảng Flutter.

class S3parentgateScreen extends StatefulWidget {
  const S3parentgateScreen({super.key});

  @override
  State<S3parentgateScreen> createState() => _S3parentgateScreenState();
}

class _S3parentgateScreenState extends State<S3parentgateScreen> {

  final int _num1 = 5;
  final int _num2 = 3;
  String _inputAnswer = '';
  String _errorMsg = '';

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
              padding: EdgeInsets.all(isTablet ? 32.0 : 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.security, size: 60, color: Color(0xFF4F46E5)),
                  const SizedBox(height: 16),
                  Text(
                    'CỔNG PHỤ HUYNH',
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vui lòng làm phép toán dưới đây để xác nhận bạn là phụ huynh.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Phép toán
                  Text(
                    '$_num1 + $_num2 = ?',
                    style: TextStyle(
                      fontSize: isTablet ? 48 : 36,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF4F46E5),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Khung hiển thị câu trả lời
                  Container(
                    width: 150,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _inputAnswer.isEmpty ? '?' : _inputAnswer,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                    ),
                  ),
                  if (_errorMsg.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(_errorMsg, style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                  const SizedBox(height: 24),
                  // Bàn phím số thiết kế to, thân thiện
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      ...List.generate(9, (index) {
                        final num = index + 1;
                        return ElevatedButton(
                          onPressed: () => setState(() => _inputAnswer += num.toString()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0F172A),
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('$num', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        );
                      }),
                      ElevatedButton(
                        onPressed: () => setState(() => _inputAnswer = ''),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEE2E2),
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('C', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => _inputAnswer += '0'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0F172A),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_inputAnswer == (_num1 + _num2).toString()) {
                            setState(() => _errorMsg = 'Xác thực thành công!');
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushReplacementNamed(context, '/s17_parent_dashboard');
                            });
                          } else {
                            setState(() {
                              _errorMsg = 'Sai rồi ba mẹ ơi!';
                              _inputAnswer = '';
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFECFDF5),
                          foregroundColor: const Color(0xFF10B981),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('✓', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
