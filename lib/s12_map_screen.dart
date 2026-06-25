import 'package:flutter/material.dart';
import 'dart:math' as math;

/// LEARNING MAP - Duolingo-style zigzag winding path
/// Nodes snake left→right→left down the screen, connected by a continuous curved road

class S12mapScreen extends StatefulWidget {
  const S12mapScreen({super.key});

  @override
  State<S12mapScreen> createState() => _S12mapScreenState();
}

class _S12mapScreenState extends State<S12mapScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _floatCtrl;
  late Animation<double> _pulseAnim;
  late Animation<double> _floatAnim;

  // Danh sách node - status: 0=done, 1=active, 2=locked
  final List<_Node> nodes = [
    _Node('A', 0),
    _Node('B', 0),
    _Node('C', 0),
    _Node('D', 1), // đang học - có pulse
    _Node('E', 2),
    _Node('F', 2, isChest: true),
    _Node('G', 2),
    _Node('H', 2),
    _Node('I', 2),
    _Node('J', 2, isChest: true),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..repeat(reverse: true);
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.18,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
    _floatAnim = Tween<double>(
      begin: 0,
      end: 7,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  // Tính toán vị trí zigzag cho từng node
  // Mỗi hàng có 3 node, hàng lẻ: trái→phải, hàng chẵn: phải→trái
  List<Offset> _computePositions(double width, double height) {
    final positions = <Offset>[];
    const int cols = 3;
    final double nodeSpacingX = width / (cols + 1);
    final double nodeSpacingY = 110.0;

    // Các cột X cơ bản
    final double x1 = nodeSpacingX * 0.9;
    final double x2 = width / 2;
    final double x3 = width - nodeSpacingX * 0.9;

    // Zigzag theo từng hàng 3 node
    for (int i = 0; i < nodes.length; i++) {
      final int row = i ~/ cols;
      final int col = i % cols;
      final double y = 60.0 + row * nodeSpacingY;

      double x;
      if (row % 2 == 0) {
        // trái → phải
        x = col == 0
            ? x1
            : col == 1
            ? x2
            : x3;
      } else {
        // phải → trái
        x = col == 0
            ? x3
            : col == 1
            ? x2
            : x1;
      }
      positions.add(Offset(x, y));
    }
    return positions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildXpBar(),
            Expanded(child: _buildMap()),
            _buildBottomBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/s4_home'),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF64748B),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'BẢN ĐỒ HỌC TẬP',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'Alphabet Road',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.favorite_rounded,
            color: Color(0xFFEF4444),
            size: 20,
          ),
          const SizedBox(width: 4),
          const Text(
            '5',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFF97316),
            size: 20,
          ),
          const SizedBox(width: 4),
          const Text(
            '7',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildXpBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          const Text('⭐', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 0.3,
                minHeight: 9,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6366F1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '30 XP',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF6366F1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return LayoutBuilder(
      builder: (ctx, box) {
        final w = box.maxWidth;
        final positions = _computePositions(w, box.maxHeight);
        final double totalHeight = positions.last.dy + 100;

        return SingleChildScrollView(
          child: SizedBox(
            width: w,
            height: math.max(totalHeight, box.maxHeight),
            child: Stack(
              children: [
                // Đường path vẽ phía sau
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RoadPainter(positions: positions, nodes: nodes),
                  ),
                ),
                // Mascot gấu floating
                AnimatedBuilder(
                  animation: _floatAnim,
                  builder: (_, __) => Positioned(
                    left: 16,
                    top: 8 - _floatAnim.value,
                    child: _buildMascot(),
                  ),
                ),
                // Các node
                for (int i = 0; i < nodes.length; i++)
                  _buildNodeWidget(nodes[i], positions[i], i),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMascot() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Center(child: Text('🐻', style: TextStyle(fontSize: 28))),
    );
  }

  Widget _buildNodeWidget(_Node node, Offset pos, int index) {
    const double r = 26.0; // radius
    return Positioned(
      left: pos.dx - r - 14, // account for pulse wrapper
      top: pos.dy - r - 14,
      child: _NodeWidget(
        node: node,
        pulseAnim: _pulseAnim,
        onTap: () {
          if (node.status != 2) Navigator.pushNamed(context, '/s6_lesson');
        },
      ),
    );
  }

  Widget _buildBottomBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/s13_quiz_result'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 4,
            shadowColor: const Color(0xFF4F46E5).withOpacity(0.4),
          ),
          child: const Text(
            'Xem Kết quả ôn tập (Quiz Result) ➔',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// Data model
// ─────────────────────────────────────────
class _Node {
  final String label;
  final int status; // 0=done 1=active 2=locked
  final bool isChest;

  const _Node(this.label, this.status, {this.isChest = false});
}

// ─────────────────────────────────────────
// CustomPainter - vẽ con đường uốn lượn
// ─────────────────────────────────────────
class _RoadPainter extends CustomPainter {
  final List<Offset> positions;
  final List<_Node> nodes;

  const _RoadPainter({required this.positions, required this.nodes});

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.length < 2) return;

    // ── Vẽ đường nền (màu xám nhạt - phần chưa học)
    final bgPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final bgPath = _buildCurvePath(positions);
    canvas.drawPath(bgPath, bgPaint);

    // ── Vẽ đường đã học (màu xanh lá)
    // Chỉ vẽ từ node 0 đến node active
    final int activeIdx = nodes.indexWhere((n) => n.status == 1);
    if (activeIdx > 0) {
      final donePaint = Paint()
        ..color = const Color(0xFF34D399)
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final donePath = _buildCurvePath(positions.sublist(0, activeIdx + 1));
      canvas.drawPath(donePath, donePaint);
    }

    // ── Viền trắng hai bên đường (road edge)
    final edgePaint = Paint()
      ..color = Colors.white.withOpacity(0.55)
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..blendMode = BlendMode.overlay;

    // Không dùng blendMode overlay - chỉ vẽ 2 vạch kẻ trắng nhỏ
    final dashPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Vạch giữa đường nét đứt
    final dashPath = _buildCurvePath(positions);
    final dashMetrics = dashPath.computeMetrics();
    for (final m in dashMetrics) {
      double d = 0;
      while (d < m.length) {
        final end = math.min(d + 8, m.length);
        final seg = m.extractPath(d, end);
        canvas.drawPath(seg, dashPaint);
        d += 16;
      }
    }
  }

  Path _buildCurvePath(List<Offset> pts) {
    if (pts.length == 1) return Path()..moveTo(pts[0].dx, pts[0].dy);
    final path = Path();
    path.moveTo(pts[0].dx, pts[0].dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i];
      final p1 = pts[i + 1];
      // Cubic bezier: control points dọc giữa
      final cp1 = Offset(p0.dx, (p0.dy + p1.dy) / 2);
      final cp2 = Offset(p1.dx, (p0.dy + p1.dy) / 2);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _RoadPainter old) => old.positions != positions;
}

// ─────────────────────────────────────────
// Widget từng node
// ─────────────────────────────────────────
class _NodeWidget extends StatelessWidget {
  final _Node node;
  final Animation<double> pulseAnim;
  final VoidCallback onTap;

  const _NodeWidget({
    required this.node,
    required this.pulseAnim,
    required this.onTap,
  });

  Color get _fillColor {
    switch (node.status) {
      case 0:
        return const Color(0xFF10B981);
      case 1:
        return const Color(0xFF6366F1);
      default:
        return const Color(0xFFCBD5E1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget circle = GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pulse ring cho active
                if (node.status == 1)
                  AnimatedBuilder(
                    animation: pulseAnim,
                    builder: (_, __) => Transform.scale(
                      scale: pulseAnim.value,
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF6366F1).withOpacity(0.22),
                        ),
                      ),
                    ),
                  ),
                // Vòng tròn chính
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _fillColor,
                    border: Border.all(
                      color: Colors.white,
                      width: node.status == 1 ? 4 : 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _fillColor.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(child: _buildIcon()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          _buildStatusLabel(),
        ],
      ),
    );

    return circle;
  }

  Widget _buildIcon() {
    if (node.isChest) {
      return const Text('🎁', style: TextStyle(fontSize: 20));
    }
    switch (node.status) {
      case 0:
        return const Icon(Icons.check_rounded, color: Colors.white, size: 22);
      case 1:
        return Text(
          node.label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        );
      default:
        return const Icon(Icons.lock_rounded, color: Colors.white, size: 18);
    }
  }

  Widget _buildStatusLabel() {
    String text;
    Color color;
    switch (node.status) {
      case 0:
        text = node.label;
        color = const Color(0xFF10B981);
        break;
      case 1:
        text = 'Đang học';
        color = const Color(0xFF6366F1);
        break;
      default:
        text = node.label;
        color = const Color(0xFFCBD5E1);
    }
    return Text(
      text,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color),
    );
  }
}
