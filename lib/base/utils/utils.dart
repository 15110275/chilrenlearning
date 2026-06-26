import 'dart:io';
import 'dart:ui' show DisplayFeatureType, FlutterView;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'generic.dart';

class NetworkStatusResponse {
  final bool isConnected;
  final String message;
  final ConnectivityResult result;

  NetworkStatusResponse({
    required this.isConnected,
    required this.message,
    required this.result,
  });
}

class Utils {
  Utils._();

  static final I = Utils._();

  /// Kết quả native Android: foldable device (Samsung Z Fold, Pixel Fold, OnePlus Open, etc.). null = chưa load.
  static bool? _androidFoldableFromNative;
  static bool _androidFoldableLoadStarted = false;
  static const _deviceChannel = MethodChannel('com.viettel.voffice/device');

  /// Cached: đã từng thấy inner screen đủ lớn cho tablet (shortestSide >= 600dp).
  /// Dùng để vẫn show config khi đang ở cover screen của book-style foldable.
  static bool _hasSeenTabletScreen = false;

  /// Chỉ Android: gọi native check foldable (FEATURE_SENSOR_HINGE_ANGLE + model check), cache kết quả.
  /// Hỗ trợ tất cả các dòng foldable: Samsung Z Fold/Flip, Pixel Fold, OnePlus Open,
  /// Xiaomi Mix Fold, Motorola Razr, Honor Magic V, OPPO Find N, vivo X Fold, etc.
  /// iOS không gọi. Chạy 1 lần.
  static Future<void> loadAndroidFoldableCache() async {
    if (!Platform.isAndroid || _androidFoldableLoadStarted) return;
    _androidFoldableLoadStarted = true;
    try {
      _androidFoldableFromNative =
          await _deviceChannel.invokeMethod<bool>('isFoldableDevice') ?? false;
    } catch (_) {
      // Fallback: nếu method channel chưa sẵn sàng, để null → sẽ check displayFeatures.
      _androidFoldableFromNative = null;
    }
  }

  /// Cache fallback: đã từng thấy hinge/fold (displayFeatures) khi native chưa có kết quả.
  static bool _androidFoldableCached = false;

  /// Cache kết quả checkIsMobile() hợp lệ gần nhất.
  /// Dùng fallback khi physicalSize trả về Size.zero (ví dụ khi resume từ background trên iOS).
  static bool? _isMobileCached;

  /// Chỉ Android: check thiết bị foldable (tất cả các hãng). iOS không cần check (luôn return false).
  /// Detection layers:
  /// 1. Native check (FEATURE_SENSOR_HINGE_ANGLE + model patterns) — nếu true → foldable chắc chắn.
  /// 2. Flutter displayFeatures (hinge/fold) — fallback cho mọi trường hợp native chưa sẵn sàng hoặc miss.
  bool isAndroidFoldable(FlutterView view) {
    if (!Platform.isAndroid) return false;

    // Native đã xác nhận là foldable → return ngay.
    if (_androidFoldableFromNative == true) return true;

    // Native chưa load xong → trigger load (async, kết quả lần sau).
    if (_androidFoldableFromNative == null) {
      loadAndroidFoldableCache();
    }

    // Luôn check displayFeatures làm fallback, kể cả khi native = false.
    // Native có thể miss một số device chưa có trong danh sách model patterns.
    for (final f in view.displayFeatures) {
      if (f.type == DisplayFeatureType.hinge ||
          f.type == DisplayFeatureType.fold) {
        _androidFoldableCached = true;
        return true;
      }
    }
    return _androidFoldableCached;
  }

  final toolTipKey = GlobalKey();

  final justToolTipKey = GlobalKey();

  Future<String> deviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String appVersion = "$appName Version $version Build $buildNumber";
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return "${info.device} - ${info.manufacturer} - ${info.version.release} - $appVersion";
    } else {
      final info = await deviceInfo.iosInfo;
      return "${info.name} - ${info.systemName} - ${info.systemVersion} - $appVersion";
    }
  }

  String convertTimestampToDateString({
    required int timestamp,
    bool needSpecificTime = false,
  }) {
    int secondsSinceEpoch = timestamp ~/ 1000;

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      secondsSinceEpoch * 1000,
    );

    String formattedDateTime =
        "${_twoDigits(dateTime.day)}/${_twoDigits(dateTime.month)}/${dateTime.year}";

    if (needSpecificTime) {
      return "${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)} - $formattedDateTime";
    }

    return formattedDateTime;
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  Future<String> getDeviceId() async {
    final nowInMillis = DateTime.now().millisecondsSinceEpoch.toString();
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.id.isNotEmpty ? info.id : nowInMillis;
    } else {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor ?? nowInMillis;
    }
  }

  // bool checkIsMobile() {
  //   // return false;
  //   return !Device.get().isTablet;
  // }

  /// Chỉ hiển thị mục cấu hình hiển thị (Điện thoại / Máy tính bảng) khi:
  /// 1. Android + foldable device (hinge/fold detection)
  /// 2. Inner screen đủ lớn cho tablet layout (shortestSide >= 600dp)
  ///
  /// Flip phones (Z Flip, Razr) có hinge nhưng inner screen vẫn phone-sized
  /// → hiển thị option tablet không có tác dụng vì checkIsMobile() luôn ép mobile.
  bool shouldShowDeviceDisplayConfig() {
    if (!Platform.isAndroid) return false;
    final views = PlatformDispatcher.instance.views;
    if (views.isEmpty) return false;
    final view = views.first;
    if (!isAndroidFoldable(view)) return false;

    // Chỉ hiện config khi inner screen đạt ngưỡng tablet (>= 600dp).
    // Lấy max logical width (inner screen luôn lớn hơn cover) từ view hiện tại
    // hoặc từ cached metrics.
    final dpr = view.devicePixelRatio;
    if (dpr <= 0) return false;
    final logicalWidth = view.physicalSize.width / dpr;
    final logicalHeight = view.physicalSize.height / dpr;
    final shortestSide = logicalWidth < logicalHeight
        ? logicalWidth
        : logicalHeight;

    // Inner screen của book-style foldable: shortestSide >= 600dp (Z Fold ~884dp width)
    // Cover screen hoặc flip phone: shortestSide < 600dp → không show config
    if (shortestSide >= 600) {
      _hasSeenTabletScreen = true;
      return true;
    }
    // Đang ở cover screen: nếu đã từng thấy inner screen đủ lớn → vẫn show config
    return _hasSeenTabletScreen;
  }

  bool checkIsMobile() {
    final dispatcher = PlatformDispatcher.instance;
    final views = dispatcher.views;
    if (views.isEmpty) {
      return _isMobileCached ?? true; // fallback: mobile khi chưa có view
    }
    final view = views.first;

    final physicalSize = view.physicalSize;
    final devicePixelRatio = view.devicePixelRatio;

    // Guard: khi physicalSize chưa sẵn sàng (ví dụ khi resume từ background trên iOS),
    // trả về giá trị cached nếu có, hoặc fallback dùng Device library.
    if (physicalSize.isEmpty ||
        physicalSize.width == 0 ||
        physicalSize.height == 0) {
      if (_isMobileCached != null) return _isMobileCached!;
      // Chưa từng có cache → fallback dùng flutter_device_type
      _isMobileCached = !Device.get().isTablet;
      return _isMobileCached!;
    }

    final logicalWidth = physicalSize.width / devicePixelRatio;
    final logicalHeight = physicalSize.height / devicePixelRatio;
    final shortestSide = logicalWidth < logicalHeight
        ? logicalWidth
        : logicalHeight;

    bool isMobile;

    // iOS: check theo kích thước như thường
    if (Platform.isIOS) {
      isMobile = shortestSide < 600;
    }
    // Android thường (không phải Z Fold): check theo kích thước như thường
    else if (Platform.isAndroid && !isAndroidFoldable(view)) {
      isMobile = shortestSide < 600;
    }
    // Android foldable (tất cả các hãng):
    // - Cover screen (gập, shortestSide < 600): luôn mobile portrait bất kể config
    // - Inner screen (mở, shortestSide >= 600): theo config user (mobile hoặc tablet)
    else if (Platform.isAndroid && isAndroidFoldable(view)) {
      if (shortestSide < 600) {
        // Cover screen → luôn mobile portrait
        isMobile = true;
      } else {
        isMobile = _androidFoldableCached
            ? _isMobileCached ?? true
            : !Device.get().isTablet;
      }
    } else {
      isMobile = shortestSide < 600;
    }

    // Cache lại kết quả hợp lệ
    _isMobileCached = isMobile;
    return isMobile;
  }

  static Future<List<ConnectivityResult>> checkNetwork() async {
    final Connectivity connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();
    return result;
  }

  bool isValidDateRange(String? dateRange) {
    if (dateRange.isNullOrEmpty) return false;
    final RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4} - \d{2}/\d{2}/\d{4}$');
    return regex.hasMatch(dateRange ?? "");
  }

  static String removeSpecialCharacters(String input) {
    return input.replaceAll(RegExp(r'[^a-zA-ZÀ-ỹ\s]'), '');
  }

  static String handleShowSoliderLevel(String? level, String name) {
    if (!level.isNullOrEmpty) {
      return "$level - $name";
    }
    return name;
  }

  static String handleShowPosition(String pos, String name) {
    if (!pos.isNullOrEmpty) {
      return "$pos - $name";
    }
    return name;
  }

  Future<int> getAndroidSdkVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    return info.version.sdkInt;
  }
}

class VersionComparator {
  static const int COMPARE_BIGGER = 1;
  static const int COMPARE_EQUAL = 0;
  static const int COMPARE_SMALLER = -1;

  static int compareStringVersion(String string1, String string2) {
    // Split the version strings into components
    List<String> array1 = string1.split('.');
    List<String> array2 = string2.split('.');

    // Equalize the lengths by appending "0" to the shorter list
    while (array1.length < array2.length) {
      array1.add('0');
    }
    while (array2.length < array1.length) {
      array2.add('0');
    }

    // Compare each component numerically
    for (int i = 0; i < array1.length; i++) {
      int num1 = int.parse(array1[i]);
      int num2 = int.parse(array2[i]);

      if (num1 > num2) {
        return COMPARE_BIGGER;
      } else if (num1 < num2) {
        return COMPARE_SMALLER;
      }
    }

    return COMPARE_EQUAL; // Versions are equal
  }
}
