import 'package:flutter/material.dart';
import 'package:pistachio/view/page/register/widget.dart';
import 'package:pistachio/view/widget/widget/app_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: CarouselView(),
    );
  }
}
