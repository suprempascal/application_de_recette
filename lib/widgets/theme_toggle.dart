import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          icon: Icon(
            themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: themeProvider.toggleTheme,
          tooltip: themeProvider.isDark ? 'Mode clair' : 'Mode sombre',
        );
      },
    );
  }
}
