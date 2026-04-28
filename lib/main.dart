import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manger.dart';
import 'package:tasky_app/core/theme/dark_theme.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/screens/main_screen.dart';
import 'package:tasky_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManger().init();
  ThemeController().init();
  final username = PreferenceManger().getString('username');
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,

      builder: (context, value, child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          debugShowCheckedModeBanner: false,
          home: username == null ? WelcomeScreen() : const MainScreen(),
        );
      },
    );
  }
}
