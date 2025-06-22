import 'package:flutter/material.dart';
import 'package:rick_and_morty_prj/core/constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final List<Widget>? actions;

  const CustomAppBar({super.key, this.titleText, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText ?? AppConstants.appName),
      centerTitle: true,
      backgroundColor: Colors.green,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
