import 'package:chidren_learning/pages/onboarding/onboarding_screen.dart';
import 'package:chidren_learning/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/app_localizations.dart';

// =========================================================================
// 1. DANH SÁCH KHAI BÁO IMPORT (ĐỒNG BỘ 100% VỚI THƯ MỤC CỦA BẠN)
// Khi bạn viết xong Class bên trong file nào, hãy bỏ dấu '//' ở đầu dòng đó.
// =========================================================================
import 'pages/parent/gate/parent_gate_screen.dart';
import 'pages/home/s4_home_screen.dart';
import 's5_module_screen.dart';
import 'pages/lesson/s6_lesson_screen.dart';
import 's7_quiz_screen.dart';
import 's8_reward_screen.dart';
import 's9_daily_mission_screen.dart';
import 's10_streak_screen.dart';
import 's11_badges_screen.dart';
import 's12_map_screen.dart';
import 's13_quiz_result_screen.dart';
import 's14_reward_shop_screen.dart';
import 's15_multi_child_screen.dart';
import 's16_report_screen.dart';
import 'pages/parent/home/dashboard/parent_dashboard_screen.dart';
import 's18_goal_setting_screen.dart';
import 's19_screen_time_screen.dart';
import 's20_parent_settings_screen.dart';
import 's21_paywall_screen.dart';
import 's22_content-mgmt_screen.dart';

void main() {
  // Cấu hình hiển thị thanh trạng thái (Status Bar) mượt mà
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Khóa cứng ứng dụng ở chế độ màn hình dọc (Portrait) tối ưu cho trẻ nhỏ học tập
  WidgetsFlutterBinding.ensureInitialized();
  // ✅ MỚI: Cho phép xoay màn hình - PORTRAIT & LANDSCAPE
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft, // ← THÊM
    DeviceOrientation.landscapeRight, // ← THÊM
  ]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const BeHocTiengAnhApp();
      },
    ),
  );
}

class BeHocTiengAnhApp extends StatelessWidget {
  const BeHocTiengAnhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bé Học Tiếng Anh Offline',
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // =========================================================================
      // 2. DESIGN SYSTEM THEME: Ngôn ngữ thiết kế trực quan, tươi sáng cho trẻ
      // =========================================================================
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          // Indigo chủ đạo cao cấp
          primary: const Color(0xFF4F46E5),
          secondary: const Color(0xFFF59E0B),
          // Hổ phách rực rỡ vui nhộn
          tertiary: const Color(0xFF10B981),
          // Xanh lá cây năng lượng
          surface: Colors.white,
        ),

        fontFamily: 'Inter',
        // Font chữ tròn trịa, hiện đại và rất dễ đọc

        // Cấu hình Card bo góc tròn trịa 24dp ngộ nghĩnh
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withValues(alpha: 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),

        // Thiết kế nút bấm kích thước cực đại, chống các bé bấm trượt
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
            shadowColor: const Color(0xFF4F46E5).withValues(alpha: 0.2),
          ),
        ),
      ),

      // Điểm khởi phát mặc định (Router tự động chuyển tiếp từ Splash)
      initialRoute: '/',

      // =========================================================================
      // 3. ROUTING SYSTEM: Điều hướng thích ứng thông minh cho cả 22 màn hình
      // =========================================================================
      onGenerateRoute: (RouteSettings settings) {
        Widget builder;

        switch (settings.name) {
          case '/':
            builder = const SplashScreen(); // Luồng Splash tự động chuyển tiếp
            break;

          case '/s1_splash':
            // Khi s1 đã sẵn sàng, hãy bỏ cmt dòng dưới:
            builder = const SplashScreen();
            // builder = const DummyScreenPlaceholder(id: 1, name: 'Splash Screen');
            break;

          case '/s2_onboarding':
            // Khi s2 đã sẵn sàng, hãy bỏ cmt dòng dưới:
            builder = const OnboardingScreen();
            // builder = const DummyScreenPlaceholder(id: 2, name: 'Onboarding Carousel');
            break;

          case '/s3_parent_gate':
            // Khi s3 đã sẵn sàng, hãy bỏ cmt dòng dưới:
            builder = const ParentGateScreen();
            // builder = const DummyScreenPlaceholder(id: 3, name: 'Parent Gate Challenge');
            break;

          case '/s4_home':
            // Màn hình trang chủ tích hợp responsive thông minh
            builder = const HomeScreen();
            // builder = const MainResponsiveNavigation();
            break;

          case '/s5_module':
            // Khi s5 đã sẵn sàng:
            final topic = settings.arguments is String
                ? settings.arguments as String
                : 'alphabet';
            builder = S5moduleScreen(topic: topic);
            // builder = const DummyScreenPlaceholder(id: 5, name: 'Grid Lessons List');
            break;

          case '/s6_lesson':
            // Khi s6 đã sẵn sàng:
            final args = settings.arguments;
            final initialLessonIndex = args is Map
                ? (args['index'] is int ? args['index'] as int : 0)
                : (args is int ? args : 0);
            final topic = args is Map && args['topic'] is String
                ? args['topic'] as String
                : 'alphabet';
            builder = S6lessonScreen(
              initialLessonIndex: initialLessonIndex,
              topic: topic,
            );
            // builder = const DummyScreenPlaceholder(id: 6, name: 'Flashcard IPA Audio');
            break;

          case '/s7_quiz':
            // Khi s7 đã sẵn sàng:
            builder = const S7quizScreen();
            // builder = const DummyScreenPlaceholder(id: 7, name: 'Question Challenge');
            break;

          case '/s8_reward':
            // Khi s8 đã sẵn sàng:
            builder = const S8rewardScreen();
            // builder = const DummyScreenPlaceholder(id: 8, name: 'Success Celebration');
            break;

          case '/s9_daily_mission':
            // Khi s9 đã sẵn sàng:
            builder = const S9dailymissionScreen();
            // builder = const DummyScreenPlaceholder(id: 9, name: 'Daily Quest Goal');
            break;

          case '/s10_streak':
            // Khi s10 đã sẵn sàng:
            builder = const S10streakScreen();
            // builder = const DummyScreenPlaceholder(id: 10, name: 'Daily Fire Calendar');
            break;

          case '/s11_badges':
            // Khi s11 đã sẵn sàng:
            builder = const S11badgesScreen();
            // builder = const DummyScreenPlaceholder(id: 11, name: 'Badge Achieved');
            break;

          case '/s12_learning_map':
            // Khi s12 đã sẵn sàng:
            builder = const S12mapScreen();
            // builder = const DummyScreenPlaceholder(id: 12, name: 'Interactive Road Map');
            break;

          case '/s13_quiz_result':
            // Khi s13 đã sẵn sàng:
            builder = const S13quizresultScreen();
            // builder = const DummyScreenPlaceholder(id: 13, name: 'Score Feedback');
            break;

          case '/s14_reward_shop':
            // Khi s14 đã sẵn sàng:
            builder = const S14rewardshopScreen();
            // builder = const DummyScreenPlaceholder(id: 14, name: 'Star Gift Store');
            break;

          case '/s15_multi_child':
            // Khi s15 đã sẵn sàng:
            builder = const S15multichildScreen();
            // builder = const DummyScreenPlaceholder(id: 15, name: 'Profiles Accounts');
            break;

          case '/s16_parent_report':
            // Khi s16 đã sẵn sàng:
            builder = const S16reportScreen();
            // builder = const DummyScreenPlaceholder(id: 16, name: 'Learning Progress');
            break;

          case '/s17_parent_dashboard':
            // Khi s17 đã sẵn sàng:
            builder = const S17parentdashboardScreen();
            // builder = const DummyScreenPlaceholder(id: 17, name: 'Parent Central Hub');
            break;

          case '/s18_goal_setting':
            // Khi s18 đã sẵn sàng:
            builder = const S18goalsettingScreen();
            // builder = const DummyScreenPlaceholder(id: 18, name: 'Study Time Goal');
            break;

          case '/s19_screen_time':
            // Khi s19 đã sẵn sàng:
            builder = const S19screentimeScreen();
            // builder = const DummyScreenPlaceholder(id: 19, name: 'Vision Eye Care Protect');
            break;

          case '/s20_parent_settings':
            // Khi s20 đã sẵn sàng:
            builder = const S20parentsettingsScreen();
            // builder = const DummyScreenPlaceholder(id: 20, name: 'Sound & System Reset');
            break;

          case '/s21_subscription_paywall':
            // Khi s21 đã sẵn sàng:
            builder = const S21paywallScreen();
            // builder = const DummyScreenPlaceholder(id: 21, name: 'VIP Membership Access');
            break;

          case '/s22_voice_chat':
            // Khi s22 đã sẵn sàng:
            builder = const S22contentmgmtScreen();
            // builder = const DummyScreenPlaceholder(id: 22, name: 'AI English Voice Chat');
            break;

          default:
            builder = const MainResponsiveNavigation();
        }

        // Tạo hiệu ứng chuyển cảnh mượt mà chuẩn điện ảnh (Fade Transition)
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => builder,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          settings: settings,
        );
      },
    );
  }
}

// =========================================================================
// 4. SPLASH SCREEN ĐIỀU PHỐI BAN ĐẦU
// Chạy giả lập 2.5 giây đầu rồi tự chuyển động mượt mà vào Onboarding (s2)
// =========================================================================
class SplashScreenRouter extends StatefulWidget {
  const SplashScreenRouter({super.key});

  @override
  State<SplashScreenRouter> createState() => _SplashScreenRouterState();
}

class _SplashScreenRouterState extends State<SplashScreenRouter> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        // Tự động chuyển tới màn giới thiệu Onboarding
        Navigator.pushReplacementNamed(context, '/s2_onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF4F46E5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🦁', style: TextStyle(fontSize: 84)),
            SizedBox(height: 24),
            Text(
              'BÉ HỌC TIẾNG ANH',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ứng dụng học tập thông minh cho trẻ nhỏ',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              width: 140,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// 5. GIAO DIỆN CHÍNH THÍCH ỨNG (MOBILE & TABLET)
// Tự động chuyển Bottom Bar ở Mobile sang Navigation Rail dọc ở Tablet
// =========================================================================
class MainResponsiveNavigation extends StatefulWidget {
  const MainResponsiveNavigation({super.key});

  @override
  State<MainResponsiveNavigation> createState() =>
      _MainResponsiveNavigationState();
}

class _MainResponsiveNavigationState extends State<MainResponsiveNavigation> {
  int _selectedNavigationIndex = 0;

  // 4 Tab chức năng cốt lõi được cấu trúc mạch lạc
  final List<Widget> _mainPages = [
    const DashboardPage(), // Tab 1: Trang chủ học tập khám phá
    const DummyLessonsPage(), // Tab 2: s5_module (Bài học)
    const DummyQuizzesPage(), // Tab 3: s7_quiz (Đố vui)
    const DummyParentPortalPage(), // Tab 4: s17_parent_dashboard (Phụ huynh)
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600; // Ngưỡng điểm gãy chuẩn của Tablet

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Thanh ứng dụng tích hợp nút bật Cẩm Nang Điều Hướng Nhanh
      appBar: AppBar(
        title: const Text(
          'Bé Học Tiếng Anh 🦁',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.rocket_launch_rounded,
              color: Colors.orangeAccent,
            ),
            tooltip: 'Xem 22 màn hình',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    '👉 Hãy vuốt từ mép trái màn hình hoặc nhấn biểu tượng Menu để chọn nhanh 22 màn hình!',
                  ),
                  duration: Duration(seconds: 4),
                ),
              );
            },
          ),
        ],
      ),

      // DRAWER DIỆU KỲ: Menu điều hướng nhanh 22 màn hình phục vụ lập trình & test
      drawer: const DevQuickNavigatorDrawer(),

      body: Row(
        children: [
          // Nếu là máy tính bảng (Tablet): Hiển thị thanh NavigationRail dọc bên trái
          if (isTablet) ...[
            NavigationRail(
              selectedIndex: _selectedNavigationIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedNavigationIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              backgroundColor: Colors.white,
              elevation: 4,
              indicatorColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              unselectedIconTheme: const IconThemeData(
                color: Colors.grey,
                size: 24,
              ),
              selectedLabelTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.school_rounded),
                  label: Text('Trang chủ'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.library_books_rounded),
                  label: Text('Bài học'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.emoji_events_rounded),
                  label: Text('Đố vui'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.supervised_user_circle_rounded),
                  label: Text('Phụ huynh'),
                ),
              ],
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
              color: Color(0xFFE2E8F0),
            ),
          ],

          // Vùng nội dung chính của Tab đang chọn
          Expanded(child: _mainPages[_selectedNavigationIndex]),
        ],
      ),

      // Nếu là điện thoại di động (Mobile): Dùng BottomNavigationBar cực đẹp vừa tầm tay bé
      bottomNavigationBar: !isTablet
          ? Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: NavigationBar(
                selectedIndex: _selectedNavigationIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedNavigationIndex = index;
                  });
                },
                backgroundColor: Colors.white,
                elevation: 0,
                indicatorColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.school_outlined),
                    selectedIcon: Icon(
                      Icons.school_rounded,
                      color: Color(0xFF4F46E5),
                    ),
                    label: 'Trang chủ',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.library_books_outlined),
                    selectedIcon: Icon(
                      Icons.library_books_rounded,
                      color: Color(0xFF4F46E5),
                    ),
                    label: 'Bài học',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.emoji_events_outlined),
                    selectedIcon: Icon(
                      Icons.emoji_events_rounded,
                      color: Color(0xFF4F46E5),
                    ),
                    label: 'Đố vui',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.supervised_user_circle_outlined),
                    selectedIcon: Icon(
                      Icons.supervised_user_circle_rounded,
                      color: Color(0xFF4F46E5),
                    ),
                    label: 'Ba Mẹ',
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

// =========================================================================
// TAB 1: KHÔNG GIAN HỌC TẬP & TIẾN TRÌNH (DASHBOARD)
// =========================================================================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 32.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thẻ chào đón bé cá nhân hóa dễ thương
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chào bé yêu! 👋',
                    style: TextStyle(
                      fontSize: isTablet ? 32 : 24,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Bé muốn học chủ đề nào hôm nay nhỉ?',
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/s15_multi_child'),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF3C7),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.transparent,
                    child: Text('🦁', style: TextStyle(fontSize: 26)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Thẻ tiến trình học tập hàng ngày của trẻ
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF818CF8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nhiệm vụ hàng ngày! 🏆',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Đã hoàn thành 3/5 bài học hôm nay.',
                        style: TextStyle(
                          color: Colors.indigo[100],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const LinearProgressIndicator(
                          value: 0.6,
                          minHeight: 8,
                          backgroundColor: Color(0xFF312E81),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/s9_daily_mission'),
                  icon: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Text('⭐', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Danh mục lựa chọn các chủ đề lớn
          const Text(
            'CHỦ ĐỀ HỌC TẬP CHÍNH',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isTablet ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.05,
            children: [
              _buildTopicCard(
                context,
                'Bảng chữ cái',
                'Alphabet',
                '🔤',
                const Color(0xFFEEF2FF),
                const Color(0xFF4F46E5),
                '/s5_module',
              ),
              _buildTopicCard(
                context,
                'Chữ số',
                'Numbers',
                '🔢',
                const Color(0xFFFEF3C7),
                const Color(0xFFD97706),
                '/s5_module',
              ),
              _buildTopicCard(
                context,
                'Động vật',
                'Animals',
                '🦁',
                const Color(0xFFECFDF5),
                const Color(0xFF10B981),
                '/s5_module',
              ),
              _buildTopicCard(
                context,
                'Màu sắc',
                'Colors',
                '🎨',
                const Color(0xFFFDF2F8),
                const Color(0xFFDB2777),
                '/s5_module',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(
    BuildContext context,
    String title,
    String subtitle,
    String emoji,
    Color bg,
    Color textCol,
    String route,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: textCol.withValues(alpha: 0.12)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 34)),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: textCol,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: textCol.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// TAB DUMMY CHO BÀI HỌC, QUÍZ VÀ PHỤ HUYNH
// =========================================================================
class DummyLessonsPage extends StatelessWidget {
  const DummyLessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📚', style: TextStyle(fontSize: 54)),
            const SizedBox(height: 16),
            const Text(
              'Danh Sách Bài Học Offline',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nút bấm dưới sẽ dẫn trực tiếp tới Màn hình S6 Lesson thực tế.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/s6_lesson'),
              icon: const Icon(Icons.play_circle_filled_rounded),
              label: const Text('Bắt Đầu Bài Học Thử Nghiệm'),
            ),
          ],
        ),
      ),
    );
  }
}

class DummyQuizzesPage extends StatelessWidget {
  const DummyQuizzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🎮', style: TextStyle(fontSize: 54)),
            const SizedBox(height: 16),
            const Text(
              'Thử Thách Đố Vui Bé Chọn Hình',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Liên kết trực tiếp tới màn chơi trò chơi S7 Quiz để kiểm tra trí nhớ.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/s7_quiz'),
              icon: const Icon(Icons.help_outline_rounded),
              label: const Text('Bắt Đầu Thách Thức'),
            ),
          ],
        ),
      ),
    );
  }
}

class DummyParentPortalPage extends StatelessWidget {
  const DummyParentPortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🛡️', style: TextStyle(fontSize: 54)),
            const SizedBox(height: 16),
            const Text(
              'Cổng Bảo Mật Dành Cho Ba Mẹ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Để vào các màn báo cáo S16 hoặc điều chỉnh giờ học S19, ba mẹ cần vượt qua bài toán S3.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/s3_parent_gate'),
              icon: const Icon(Icons.lock_person_rounded),
              label: const Text('Mở Khóa Parent Gate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// 6. CẨM NANG ĐIỀU HƯỚNG DEV: Giúp trượt đổi nhanh giữa 22 màn hình
// =========================================================================
class DevQuickNavigatorDrawer extends StatelessWidget {
  const DevQuickNavigatorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // 22 Đầu mục định tuyến chính xác với tên file của bạn
    final List<Map<String, dynamic>> allScreens = [
      {
        'route': '/s1_splash',
        'name': '01. Splash Screen',
        'icon': '📱',
        'phase': 'Học Tập',
      },
      {
        'route': '/s2_onboarding',
        'name': '02. Onboarding Carousel',
        'icon': '✨',
        'phase': 'Học Tập',
      },
      {
        'route': '/s3_parent_gate',
        'name': '03. Parent Gate Challenge',
        'icon': '🛡️',
        'phase': 'Học Tập',
      },
      {
        'route': '/s4_home',
        'name': '04. Home Dashboard',
        'icon': '🏠',
        'phase': 'Học Tập',
      },
      {
        'route': '/s5_module',
        'name': '05. Grid Lessons List',
        'icon': '🔤',
        'phase': 'Học Tập',
      },
      {
        'route': '/s6_lesson',
        'name': '06. Flashcard IPA Audio',
        'icon': '🗣️',
        'phase': 'Học Tập',
      },
      {
        'route': '/s7_quiz',
        'name': '07. Question Challenge',
        'icon': '🧩',
        'phase': 'Học Tập',
      },
      {
        'route': '/s8_reward',
        'name': '08. Success Celebration',
        'icon': '🎉',
        'phase': 'Tương Tác',
      },
      {
        'route': '/s9_daily_mission',
        'name': '09. Daily Quest Goal',
        'icon': '⭐',
        'phase': 'Tương Tác',
      },
      {
        'route': '/s10_streak',
        'name': '10. Daily Fire Calendar',
        'icon': '🔥',
        'phase': 'Tương Tác',
      },
      {
        'route': '/s11_badges',
        'name': '11. Badge Achieved',
        'icon': '🏅',
        'phase': 'Tương Tác',
      },
      {
        'route': '/s12_learning_map',
        'name': '12. Interactive Road Map',
        'icon': '🗺️',
        'phase': 'Tương Tác',
      },
      {
        'route': '/s13_quiz_result',
        'name': '13. Score Feedback',
        'icon': '📊',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s14_reward_shop',
        'name': '14. Star Gift Store',
        'icon': '🎁',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s15_multi_child',
        'name': '15. Profiles Accounts',
        'icon': '🧒',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s16_parent_report',
        'name': '16. Learning Progress',
        'icon': '📈',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s17_parent_dashboard',
        'name': '17. Parent Central Hub',
        'icon': '🗝️',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s18_goal_setting',
        'name': '18. Study Time Goal',
        'icon': '📅',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s19_screen_time',
        'name': '19. Vision Eye Protect',
        'icon': '👁️',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s20_parent_settings',
        'name': '20. Sound & System Reset',
        'icon': '⚙️',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s21_subscription_paywall',
        'name': '21. VIP Membership Access',
        'icon': '👑',
        'phase': 'Phụ Huynh',
      },
      {
        'route': '/s22_voice_chat',
        'name': '22. AI English Voice Chat',
        'icon': '🤖',
        'phase': 'Học Tập',
      },
    ];

    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 24,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CẨM NANG LIÊN KẾT',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '22 Màn Hình Flutter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Cấu trúc điều phối đồng bộ hoàn mỹ',
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              itemCount: allScreens.length,
              itemBuilder: (context, index) {
                final item = allScreens[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: ListTile(
                    dense: true,
                    leading: Text(
                      item['icon'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getPhaseColor(
                          item['phase'],
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['phase'],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: _getPhaseColor(item['phase']),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Đóng menu
                      Navigator.pushNamed(context, item['route']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getPhaseColor(String phase) {
    switch (phase) {
      case 'Học Tập':
        return const Color(0xFF4F46E5);
      case 'Tương Tác':
        return const Color(0xFFF59E0B);
      case 'Phụ Huynh':
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }
}

// =========================================================================
// 7. WIDGET GIỮ CHỖ CHỜ SẴN CLASS THỰC TẾ
// Hiển thị hướng dẫn trực quan để lập trình viên ghép code cực kỳ dễ dàng
// =========================================================================
class DummyScreenPlaceholder extends StatelessWidget {
  final int id;
  final String name;

  const DummyScreenPlaceholder({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD),
      appBar: AppBar(
        title: Text('Thử nghiệm S$id'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _getEmoji(id),
                    style: const TextStyle(fontSize: 44),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Màn Hình $name (S$id)',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      '💡 HƯỚNG DẪN GHÉP MÀN HÌNH',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bước 1: Tải file code s${id}_... từ tab mô phỏng phía trên hoặc copy từ bảng mẫu của bạn.\\n'
                      'Bước 2: Tìm mở lib/main.dart, bỏ dấu // ở dòng "import" trên đầu.\\n'
                      'Bước 3: Ở phần "onGenerateRoute", đổi widget "DummyScreenPlaceholder" thành tên Class thực tế của bạn (Ví dụ: S${id}Screen).\\n'
                      'Thế là xong! Màn hình của bạn đã được liên kết hoàn tất.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Quay Lại Dashboard Thử Nghiệm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getEmoji(int id) {
    const emojis = {
      1: '📱',
      2: '✨',
      3: '🛡️',
      4: '🏠',
      5: '🔤',
      6: '🗣️',
      7: '🧩',
      8: '🎉',
      9: '⭐',
      10: '🔥',
      11: '🏅',
      12: '🗺️',
      13: '📊',
      14: '🎁',
      15: '🧒',
      16: '📈',
      17: '🗝️',
      18: '📅',
      19: '👁️',
      20: '⚙️',
      21: '👑',
      22: '🤖',
    };
    return emojis[id] ?? '📦';
  }
}
