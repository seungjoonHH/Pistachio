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
  static const MaterialColor primary = MaterialColor(0xFFAEDB9F, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFF7FFEE),
    95: Color(0xFFCAFFB9),
    90: Color(0xFFB0F49E),
    80: Color(0xFF95D784),
    70: Color(0xFF7BBB6B),
    60: Color(0xFF619F53),
    50: Color(0xFF48853C),
    40: Color(0xFF2F6B26),
    30: Color(0xFF15520F),
    20: Color(0xFF003A00),
    10: Color(0xFF002200),
    0: Color(0xFF000000),
  });

  static const MaterialColor secondary = MaterialColor(0xFF54634D, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFF7FFEE),
    95: Color(0xFFE5F6DB),
    90: Color(0xFFD7E8CD),
    80: Color(0xFFBBCBB2),
    70: Color(0xFFA0B097),
    60: Color(0xFF85957E),
    50: Color(0xFF6C7B65),
    40: Color(0xFF54634D),
    30: Color(0xFF3C4B37),
    20: Color(0xFF263422),
    10: Color(0xFF121F0E),
    0: Color(0xFF000000),
  });

  static const MaterialColor tertiary = MaterialColor(0xFFD7CFBB, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFFFBFF),
    95: Color(0xFFFFF0C1),
    90: Color(0xFFFFE168),
    80: Color(0xFFE2C54B),
    70: Color(0xFFC5AA31),
    60: Color(0xFFA98F13),
    50: Color(0xFF8C7600),
    40: Color(0xFF6F5D00),
    30: Color(0xFF544600),
    20: Color(0xFF3A3000),
    10: Color(0xFF221B00),
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

  static const MaterialColor neutral = MaterialColor(0xFF5D5F5A, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFFCFDF6),
    95: Color(0xFFF1F1EB),
    90: Color(0xFFE2E3DC),
    80: Color(0xFFC6C7C1),
    70: Color(0xFFABACA6),
    60: Color(0xFF90918C),
    50: Color(0xFF767872),
    40: Color(0xFF5D5F5A),
    30: Color(0xFF454743),
    20: Color(0xFF2F312D),
    10: Color(0xFF1A1C18),
    0: Color(0xFF000000),
  });

  static const MaterialColor neutralVariant = MaterialColor(0xFF5A6056, {
    100: Color(0xFFFFFFFF),
    99: Color(0xFFF9FEF1),
    95: Color(0xFFEDF3E6),
    90: Color(0xFFDFE4D7),
    80: Color(0xFFC3C8BC),
    70: Color(0xFFA7ADA1),
    60: Color(0xFF8D9387),
    50: Color(0xFF73796E),
    40: Color(0xFF5A6056),
    30: Color(0xFF43483F),
    20: Color(0xFF2C3229),
    10: Color(0xFF181D15),
    0: Color(0xFF000000),
  });

  // colorScheme
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2F6B26),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFB0F49E),
    onPrimaryContainer: Color(0xFF002200),
    secondary: Color(0xFF54634D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD7E8CD),
    onSecondaryContainer: Color(0xFF121F0E),
    tertiary: Color(0xFF6F5D00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFE168),
    onTertiaryContainer: Color(0xFF221B00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFDF6),
    onBackground: Color(0xFF1A1C18),
    surface: Color(0xFFFCFDF6),
    onSurface: Color(0xFF1A1C18),
    surfaceVariant: Color(0xFFDFE4D7),
    onSurfaceVariant: Color(0xFF43483F),
    outline: Color(0xFF73796E),
    onInverseSurface: Color(0xFFF1F1EB),
    inverseSurface: Color(0xFF2F312D),
    inversePrimary: Color(0xFF95D784),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF2F6B26),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF95D784),
    onPrimary: Color(0xFF003A00),
    primaryContainer: Color(0xFF15520F),
    onPrimaryContainer: Color(0xFFB0F49E),
    secondary: Color(0xFFBBCBB2),
    onSecondary: Color(0xFF263422),
    secondaryContainer: Color(0xFF3C4B37),
    onSecondaryContainer: Color(0xFFD7E8CD),
    tertiary: Color(0xFFE2C54B),
    onTertiary: Color(0xFF3A3000),
    tertiaryContainer: Color(0xFF544600),
    onTertiaryContainer: Color(0xFFFFE168),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C18),
    onBackground: Color(0xFFE2E3DC),
    surface: Color(0xFF1A1C18),
    onSurface: Color(0xFFE2E3DC),
    surfaceVariant: Color(0xFF43483F),
    onSurfaceVariant: Color(0xFFC3C8BC),
    outline: Color(0xFF8D9387),
    onInverseSurface: Color(0xFF1A1C18),
    inverseSurface: Color(0xFFE2E3DC),
    inversePrimary: Color(0xFF2F6B26),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF95D784),
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
