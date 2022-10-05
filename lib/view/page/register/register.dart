import 'package:flutter/material.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/page/register/widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: const Scaffold(
        backgroundColor: PTheme.background,
        body: CarouselView(),
      ),
    );
  }
}
