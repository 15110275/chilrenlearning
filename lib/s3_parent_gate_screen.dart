import 'package:flutter/material.dart';
import 'dart:math';

class S3parentgateScreen extends StatefulWidget {
  const S3parentgateScreen({super.key});

  @override
  State<S3parentgateScreen> createState() => _S3parentgateScreenState();
}

class _S3parentgateScreenState extends State<S3parentgateScreen> with TickerProviderStateMixin {

  final Random _random = Random();

  late int _num1;
  late int _num2;

  String _inputAnswer = '';
  String _errorMsg = '';

  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    _generateQuestion();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

  }

  void _generateQuestion() {
    _num1 = _random.nextInt(8) + 2; // 2 -> 9
    _num2 = _random.nextInt(8) + 1; // 1 -> 8
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    if (_inputAnswer == (_num1 + _num2).toString()) {
      setState(() {
        _errorMsg = '✅ Xác thực thành công!';
      });

      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/s17_parent_dashboard',
          );
        }
      });
    } else {
      setState(() {
        _errorMsg = '❌ Sai rồi, thử lại nhé!';
        _inputAnswer = '';

        _generateQuestion();
      });
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _generateQuestion();
  }

  Widget buildKey(String value,
      {Color? bgColor,
        Color? textColor,
        VoidCallback? onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: bgColor ?? Colors.white,
        foregroundColor: textColor ?? const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final mathSize = isTablet
        ? 180.0
        : MediaQuery.of(context).size.width * 0.28;


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F2FE),
              Color(0xFFF8FAFC),
              Color(0xFFFFFBEB),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(
                isTablet ? 32 : 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 550 : 420,
                ),
                child: Container(
                  padding: EdgeInsets.all(
                    isTablet ? 32 : 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue
                            .withOpacity(0.08),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: _glowController,
                        builder: (context, child) {
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(
                                0xFFEEF2FF,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF4F46E5,
                                  ).withOpacity(
                                    0.2 +
                                        (_glowController
                                            .value *
                                            0.3),
                                  ),
                                  blurRadius:
                                  25 +
                                      (_glowController
                                          .value *
                                          20),
                                  spreadRadius:
                                  2 +
                                      (_glowController
                                          .value *
                                          4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.security,
                              size: 50,
                              color:
                              Color(0xFF4F46E5),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "CỔNG PHỤ HUYNH",
                        style: TextStyle(
                          fontSize:
                          isTablet ? 28 : 22,
                          fontWeight:
                          FontWeight.w900,
                          color:
                          const Color(0xFF0F172A),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Giải phép tính bên dưới để xác nhận bạn là phụ huynh.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                          isTablet ? 15 : 13,
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        width: mathSize,
                        height: mathSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient:
                          const LinearGradient(
                            colors: [
                              Color(0xFF6366F1),
                              Color(0xFF8B5CF6),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.indigo
                                  .withOpacity(
                                  0.3),
                              blurRadius: 20,
                              offset:
                              const Offset(
                                  0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "$_num1 + $_num2",
                            style: TextStyle(
                              fontSize:
                              isTablet
                                  ? 48
                                  : 38,
                              color: Colors.white,
                              fontWeight:
                              FontWeight.w900,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        width: isTablet ? 220 : 160,
                        height: isTablet ? 80 : 65,
                        alignment:
                        Alignment.center,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFF8FAFC),
                          borderRadius:
                          BorderRadius.circular(
                              20),
                          border: Border.all(
                            color: const Color(
                              0xFFE2E8F0,
                            ),
                          ),
                        ),
                        child: Text(
                          _inputAnswer.isEmpty
                              ? "?"
                              : _inputAnswer,
                          style:
                          const TextStyle(
                            fontSize: 34,
                            fontWeight:
                            FontWeight.w900,
                          ),
                        ),
                      ),

                      if (_errorMsg.isNotEmpty)
                        Padding(
                          padding:
                          const EdgeInsets.only(
                            top: 12,
                          ),
                          child: Text(
                            _errorMsg,
                            style: TextStyle(
                              color: _errorMsg
                                  .contains(
                                  "thành công")
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),

                      const SizedBox(height: 30),

                      GridView.count(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: isTablet ? 1.8 : 1.25,
                        children: [
                          ...List.generate(
                            9,
                                (index) {
                              final num =
                                  index + 1;

                              return buildKey(
                                "$num",
                                onTap: () {
                                  setState(() {
                                    _inputAnswer +=
                                    "$num";
                                  });
                                },
                              );
                            },
                          ),

                          buildKey(
                            "C",
                            bgColor:
                            const Color(
                              0xFFFEE2E2,
                            ),
                            textColor:
                            Colors.red,
                            onTap: () {
                              setState(() {
                                _inputAnswer =
                                '';
                              });
                            },
                          ),

                          buildKey(
                            "0",
                            onTap: () {
                              setState(() {
                                _inputAnswer +=
                                '0';
                              });
                            },
                          ),

                          buildKey(
                            "✓",
                            bgColor:
                            const Color(
                              0xFFDCFCE7,
                            ),
                            textColor:
                            const Color(
                              0xFF10B981,
                            ),
                            onTap: _checkAnswer,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}