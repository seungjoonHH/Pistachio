import 'package:firebase_core/firebase_core.dart';
import 'package:pistachio/firebase_options.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/route.dart';
import 'package:pistachio/view/page/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'pistachio',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Pistachio());
}

class Pistachio extends StatelessWidget {
  const Pistachio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalPresenter.initControllers();
    GlobalPresenter.importData();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          enableLog: false,
          title: 'Fitween',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: FWTheme.lightScheme,
            textTheme: FWTheme.textTheme,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: FWTheme.lightScheme.primary,
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: FWTheme.darkScheme,
            textTheme: FWTheme.textTheme,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: FWTheme.darkScheme.primary,
              ),
            ),
          ),
          // home: const DeveloperPage(),
          home: const HomePage(),
          getPages: FWRoute.getPages,
        );
      },
    );
  }
}
