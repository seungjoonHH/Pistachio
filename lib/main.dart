import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:pistachio/firebase_options.dart';
import 'package:pistachio/global/date.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';
import 'package:pistachio/presenter/global.dart';
import 'package:pistachio/presenter/import.dart';
import 'package:pistachio/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pistachio/view/page/login/login.dart';

const version = 'ver 0.0.1';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'pistachio',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Pistachio());
}

class Pistachio extends StatefulWidget {
  const Pistachio({Key? key}) : super(key: key);

  @override
  State<Pistachio> createState() => _PistachioState();
}

class _PistachioState extends State<Pistachio> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 500),
        AuthPresenter.loadLoginData,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    setTimeError();
    GlobalPresenter.initControllers();
    ImportPresenter.importData();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          enableLog: false,
          title: 'Pistachio',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            textTheme: PTheme.textTheme,
          ),
          // darkTheme: ThemeData(
          //   useMaterial3: true,
          //   colorScheme: PTheme.darkScheme,
          //   textTheme: PTheme.textTheme,
          //   appBarTheme: AppBarTheme(
          //     iconTheme: IconThemeData(
          //       color: PTheme.darkScheme.primary,
          //     ),
          //   ),
          // ),
          // home: const DeveloperPage(),
          home: const LoginPage(),
          getPages: PRoute.getPages,
        );
      },
    );
  }
}
