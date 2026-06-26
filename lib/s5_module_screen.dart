import 'package:flutter/material.dart';

class S5moduleScreen extends StatefulWidget {
  const S5moduleScreen({super.key, this.topic = 'alphabet'});

  final String topic;

  @override
  State<S5moduleScreen> createState() => _S5moduleScreenState();
}

class _ModuleItem {
  const _ModuleItem(this.display, this.label);

  final String display;
  final String label;
}

class _ModuleConfig {
  const _ModuleConfig({
    required this.title,
    required this.progressText,
    required this.actionText,
    required this.color,
    required this.light,
    required this.items,
  });

  final String title;
  final String progressText;
  final String actionText;
  final Color color;
  final Color light;
  final List<_ModuleItem> items;
}

class _S5moduleScreenState extends State<S5moduleScreen> {
  static const List<_ModuleItem> _alphabetItems = [
    _ModuleItem('A', 'Apple'),
    _ModuleItem('B', 'Banana'),
    _ModuleItem('C', 'Cat'),
    _ModuleItem('D', 'Dog'),
    _ModuleItem('E', 'Elephant'),
    _ModuleItem('F', 'Fish'),
    _ModuleItem('G', 'Grape'),
    _ModuleItem('H', 'House'),
    _ModuleItem('I', 'Ice cream'),
    _ModuleItem('J', 'Juice'),
    _ModuleItem('K', 'Key'),
    _ModuleItem('L', 'Lion'),
    _ModuleItem('M', 'Moon'),
    _ModuleItem('N', 'Nose'),
    _ModuleItem('O', 'Orange'),
    _ModuleItem('P', 'Pencil'),
    _ModuleItem('Q', 'Queen'),
    _ModuleItem('R', 'Rainbow'),
    _ModuleItem('S', 'Sun'),
    _ModuleItem('T', 'Train'),
    _ModuleItem('U', 'Umbrella'),
    _ModuleItem('V', 'Violin'),
    _ModuleItem('W', 'Watch'),
    _ModuleItem('X', 'Xylophone'),
    _ModuleItem('Y', 'Yo-yo'),
    _ModuleItem('Z', 'Zebra'),
  ];

  static const List<_ModuleItem> _numberItems = [
    _ModuleItem('1', 'One'),
    _ModuleItem('2', 'Two'),
    _ModuleItem('3', 'Three'),
    _ModuleItem('4', 'Four'),
    _ModuleItem('5', 'Five'),
    _ModuleItem('6', 'Six'),
    _ModuleItem('7', 'Seven'),
    _ModuleItem('8', 'Eight'),
    _ModuleItem('9', 'Nine'),
    _ModuleItem('10', 'Ten'),
    _ModuleItem('11', 'Eleven'),
    _ModuleItem('12', 'Twelve'),
    _ModuleItem('13', 'Thirteen'),
    _ModuleItem('14', 'Fourteen'),
    _ModuleItem('15', 'Fifteen'),
    _ModuleItem('16', 'Sixteen'),
    _ModuleItem('17', 'Seventeen'),
    _ModuleItem('18', 'Eighteen'),
    _ModuleItem('19', 'Nineteen'),
    _ModuleItem('20', 'Twenty'),
  ];

  static const List<_ModuleItem> _animalItems = [
    _ModuleItem('🐱', 'Cat'),
    _ModuleItem('🐶', 'Dog'),
    _ModuleItem('🦁', 'Lion'),
    _ModuleItem('🐯', 'Tiger'),
    _ModuleItem('🐘', 'Elephant'),
    _ModuleItem('🐒', 'Monkey'),
    _ModuleItem('🐼', 'Panda'),
    _ModuleItem('🐰', 'Rabbit'),
    _ModuleItem('🐟', 'Fish'),
    _ModuleItem('🐦', 'Bird'),
    _ModuleItem('🐸', 'Frog'),
    _ModuleItem('🦓', 'Zebra'),
  ];

  static const List<_ModuleItem> _colorItems = [
    _ModuleItem('🔴', 'Red'),
    _ModuleItem('🟠', 'Orange'),
    _ModuleItem('🟡', 'Yellow'),
    _ModuleItem('🟢', 'Green'),
    _ModuleItem('🔵', 'Blue'),
    _ModuleItem('🟣', 'Purple'),
    _ModuleItem('🩷', 'Pink'),
    _ModuleItem('⚫', 'Black'),
    _ModuleItem('⚪', 'White'),
    _ModuleItem('🟤', 'Brown'),
  ];

  _ModuleConfig get _config {
    switch (widget.topic) {
      case 'numbers':
        return const _ModuleConfig(
          title: 'Chữ số',
          progressText: 'Học chữ số (20/20)',
          actionText: 'Tiếp tục học số',
          color: Color(0xFFD97706),
          light: Color(0xFFFEF3C7),
          items: _numberItems,
        );
      case 'animals':
        return const _ModuleConfig(
          title: 'Động vật',
          progressText: 'Học động vật (12/12)',
          actionText: 'Tiếp tục học động vật',
          color: Color(0xFF059669),
          light: Color(0xFFD1FAE5),
          items: _animalItems,
        );
      case 'colors':
        return const _ModuleConfig(
          title: 'Màu sắc',
          progressText: 'Học màu sắc (10/10)',
          actionText: 'Tiếp tục học màu sắc',
          color: Color(0xFFDB2777),
          light: Color(0xFFFCE7F3),
          items: _colorItems,
        );
      default:
        return const _ModuleConfig(
          title: 'Alphabet',
          progressText: 'Học bảng chữ cái (26/26)',
          actionText: 'Tiếp tục học chữ cái',
          color: Color(0xFF0284C7),
          light: Color(0xFFE0F2FE),
          items: _alphabetItems,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final config = _config;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD),
      body: SafeArea(
        child: Padding(
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
                    onPressed: () => Navigator.pushNamed(context, '/s4_home'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: config.light,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      config.progressText,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: config.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                config.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 5 : 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: config.items.length,
                  itemBuilder: (context, index) {
                    final item = config.items[index];
                    final bool learned = index < 5;
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/s6_lesson',
                          arguments: {'topic': widget.topic, 'index': index},
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: learned ? config.light : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: learned
                                ? config.color.withValues(alpha: 0.4)
                                : const Color(0xFFE2E8F0),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.display,
                                style: TextStyle(
                                  fontSize: item.display.length > 2 ? 20 : 24,
                                  fontWeight: FontWeight.bold,
                                  color: learned
                                      ? config.color
                                      : const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text(
                                item.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ),
                            if (learned) ...[
                              const SizedBox(height: 2),
                              Text(
                                'ĐÃ HỌC',
                                style: TextStyle(
                                  fontSize: 6,
                                  fontWeight: FontWeight.w800,
                                  color: config.color,
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
                    Navigator.pushNamed(
                      context,
                      '/s6_lesson',
                      arguments: {'topic': widget.topic, 'index': 0},
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: config.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    '${config.actionText} ➔',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
