import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: const Text('Fitween',
        style: TextStyle(color: Color(0xfff7ecde)),
      ),
      iconTheme: const IconThemeData(color: Color(0xfff7ecde)),
      backgroundColor: const Color(0xff54bab9),
    );
  }
}