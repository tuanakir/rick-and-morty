import 'package:flutter/material.dart';

class LanguageToggleButton extends StatelessWidget {
  final VoidCallback onToggle;
  final String currentLang;

  const LanguageToggleButton({
    Key? key,
    required this.onToggle,
    required this.currentLang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onToggle,
      child: Text(currentLang == 'tr' ? 'EN' : 'TR'),
    );
  }
}
