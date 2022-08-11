/* 테마 관련 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// global variables
// 텍스트 테마
TextTheme textTheme = Theme.of(Get.context!).textTheme;

// 컬러 스키마
ColorScheme colorScheme = Theme.of(Get.context!).colorScheme;

/// class
class PTheme {
  /// colors
  // simple
  static const Color black = Colors.black;
  static const Color dark = Color(0xFF1F1F1F);
  static const Color grey = Color(0xFF929292);
  static const Color light = Color(0xFFF5F5F5);
  static const Color white = Colors.white;
  // static const Color fitween1 = Color(0xFF0086FF);
  // static const Color fitween2 = Color(0xFF00DBFF);
  // static const Color fitween3 = Color(0xFFA5C8FF);
  // static const Color fitween4 = Color(0xFFD4E3FF);
  // static const LinearGradient fitweenGradient = LinearGradient(
  //   colors: [fitween1, fitween2],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );
  // static const LinearGradient cardGradient = LinearGradient(
  //   colors: [fitween4, fitween3],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );

  // materialColor
  static const MaterialColor primary = MaterialColor(0xFF54BAB9, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFF1FFFE),
    95: Color(0xFFAEFFFE),
    90: Color(0xFF6FF7F5),
    80: Color(0xFF4DDAD9),
    70: Color(0xFF1FBEBD),
    60: Color(0xFF00A1A1),
    50: Color(0xFF008584),
    40: Color(0xFF006A69),
    30: Color(0xFF00504F),
    20: Color(0xFF003737),
    10: Color(0xFF002020),
    0: Color(0xFF000000),
  });

  static const MaterialColor secondary = MaterialColor(0xFFE9DAC1, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFFFBFF),
    95: Color(0xFFFFEFD4),
    90: Color(0xFFFFDF9E),
    80: Color(0xFFF2BF48),
    70: Color(0xFFD4A42E),
    60: Color(0xFFB68A0E),
    50: Color(0xFF977100),
    40: Color(0xFF795900),
    30: Color(0xFF5B4300),
    20: Color(0xFF3F2E00),
    10: Color(0xFF261A00),
    0: Color(0xFF000000),
  });

  static const MaterialColor tertiary = MaterialColor(0xFFF7ECDE, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFFFBFF),
    95: Color(0xFFFFEFD6),
    90: Color(0xFFFFDEA4),
    80: Color(0xFFF5BE48),
    70: Color(0xFFD7A32E),
    60: Color(0xFFB9890F),
    50: Color(0xFF9A7000),
    40: Color(0xFF7B5900),
    30: Color(0xFF5D4200),
    20: Color(0xFF412D00),
    10: Color(0xFF261900),
    0: Color(0xFF000000),
  });

  static const MaterialColor error = MaterialColor(0xFFBA1A1A, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFFFBFF),
    95: Color(0xFFFFEDEA),
    90: Color(0xFFFFDAD6),
    80: Color(0xFFFFB4AB),
    70: Color(0xFFFF897D),
    60: Color(0xFFFF5449),
    50: Color(0xFFDE3730),
    40: Color(0xFFBA1A1A),
    30: Color(0xFF93000A),
    20: Color(0xFF690005),
    10: Color(0xFF410002),
    0: Color(0xFF000000),
  });

  static const MaterialColor neutral = MaterialColor(0xFF5B5F5F, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFAFDFC),
    95: Color(0xFFEFF1F0),
    90: Color(0xFFE0E3E2),
    80: Color(0xFFC4C7C6),
    70: Color(0xFFA9ACAB),
    60: Color(0xFF8E9191),
    50: Color(0xFF747877),
    40: Color(0xFF5B5F5F),
    30: Color(0xFF444747),
    20: Color(0xFF2D3131),
    10: Color(0xFF191C1C),
    0: Color(0xFF000000),
  });

  static const MaterialColor neutralVariant = MaterialColor(0xFF566060, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFF4FEFD),
    95: Color(0xFFE9F3F2),
    90: Color(0xFFDAE5E4),
    80: Color(0xFFBEC9C8),
    70: Color(0xFFA3ADAC),
    60: Color(0xFF889392),
    50: Color(0xFF6F7978),
    40: Color(0xFF566060),
    30: Color(0xFF3F4948),
    20: Color(0xFF293232),
    10: Color(0xFF141D1D),
    0: Color(0xFF000000),
  });

  // colorScheme
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006A69),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF6FF7F5),
    onPrimaryContainer: Color(0xFF002020),
    secondary: Color(0xFF795900),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDF9E),
    onSecondaryContainer: Color(0xFF261A00),
    tertiary: Color(0xFF7B5900),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDEA4),
    onTertiaryContainer: Color(0xFF261900),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFAFDFC),
    onBackground: Color(0xFF191C1C),
    surface: Color(0xFFFAFDFC),
    onSurface: Color(0xFF191C1C),
    surfaceVariant: Color(0xFFDAE5E4),
    onSurfaceVariant: Color(0xFF3F4948),
    outline: Color(0xFF6F7978),
    onInverseSurface: Color(0xFFEFF1F0),
    inverseSurface: Color(0xFF2D3131),
    inversePrimary: Color(0xFF4DDAD9),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006A69),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF4DDAD9),
    onPrimary: Color(0xFF003737),
    primaryContainer: Color(0xFF00504F),
    onPrimaryContainer: Color(0xFF6FF7F5),
    secondary: Color(0xFFF2BF48),
    onSecondary: Color(0xFF3F2E00),
    secondaryContainer: Color(0xFF5B4300),
    onSecondaryContainer: Color(0xFFFFDF9E),
    tertiary: Color(0xFFF5BE48),
    onTertiary: Color(0xFF412D00),
    tertiaryContainer: Color(0xFF5D4200),
    onTertiaryContainer: Color(0xFFFFDEA4),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF191C1C),
    onBackground: Color(0xFFE0E3E2),
    surface: Color(0xFF191C1C),
    onSurface: Color(0xFFE0E3E2),
    surfaceVariant: Color(0xFF3F4948),
    onSurfaceVariant: Color(0xFFBEC9C8),
    outline: Color(0xFF889392),
    onInverseSurface: Color(0xFF191C1C),
    inverseSurface: Color(0xFFE0E3E2),
    inversePrimary: Color(0xFF006A69),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4DDAD9),
  );

  // surface
  static Map<int, Color> get surface => {
    Brightness.light: {
      1: Color.alphaBlend(
        primary[40]!.withOpacity(.05),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      2: Color.alphaBlend(
        primary[40]!.withOpacity(.08),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      3: Color.alphaBlend(
        primary[40]!.withOpacity(.11),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      4: Color.alphaBlend(
        primary[40]!.withOpacity(.12),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      5: Color.alphaBlend(
        primary[40]!.withOpacity(.14),
        Theme.of(Get.context!).colorScheme.surface,
      ),
    },
    Brightness.dark: {
      1: Color.alphaBlend(
        primary[80]!.withOpacity(.05),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      2: Color.alphaBlend(
        primary[80]!.withOpacity(.08),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      3: Color.alphaBlend(
        primary[80]!.withOpacity(.11),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      4: Color.alphaBlend(
        primary[80]!.withOpacity(.12),
        Theme.of(Get.context!).colorScheme.surface,
      ),
      5: Color.alphaBlend(
        primary[80]!.withOpacity(.14),
        Theme.of(Get.context!).colorScheme.surface,
      ),
    },
  }[Theme.of(Get.context!).brightness]!;

  /// typography
  static const fontFamily = 'Noto_Sans_KR';

  static TextTheme textTheme = TextTheme(

    //Headline
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 32.0.sp,
      height: (40 / 32).h,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24.0.sp,
      height: (36 / 24).h,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 16.0.sp,
      height: (32 / 16).h,
    ),

    //Title
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 22.0.sp,
      height: (28 / 22).h,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18.0.sp,
      height: (24 / 18).h,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14.0.sp,
      height: (20 / 14).h,
    ),

    //Label
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 16.0.sp,
      height: (20 / 16).h,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
      height: (16 / 12).h,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 11.0.sp,
      height: (16 / 11).h,
    ),

    //Body
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16.0.sp,
      height: (24 / 16).h,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14.0.sp,
      height: (20 / 14).h,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 12.0.sp,
      height: (16 / 12).h,
    ),
  );
}
