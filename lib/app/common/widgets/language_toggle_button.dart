import 'package:flutter/material.dart';

class LanguageToggleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String currentLanguageCode;

  const LanguageToggleButton({
    Key? key,
    required this.onPressed,
    required this.currentLanguageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(currentLanguageCode == 'tr' ? 'EN' : 'TR'),
    );
  }
}
