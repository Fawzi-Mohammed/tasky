import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tasky_app/core/constants/storage_key.dart';
import 'package:tasky_app/core/services/hive_storage_manager.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/theme/dark_theme.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/features/navigation/main_screen.dart';
import 'package:tasky_app/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  await ScreenUtil.ensureScreenSize();
  ThemeController().init();
  await HiveStorageManager().init();
  final username = PreferenceManager().getString(StorageKey.userName);
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
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController()..init(),
          child: ScreenUtilInit(
            designSize: const Size(375, 809),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              title: 'Tasky',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: value,
              debugShowCheckedModeBanner: false,
              home: username == null ? WelcomeScreen() : const MainScreen(),
            ),
          ),
        );
      },
    );
  }
}
