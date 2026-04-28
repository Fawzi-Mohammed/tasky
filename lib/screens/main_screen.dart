import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/screens/complete_tasks_screen.dart';
import 'package:tasky_app/screens/home_screen.dart';
import 'package:tasky_app/screens/profile_screen.dart';
import 'package:tasky_app/screens/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const List<Widget> _screen = [
    HomeScreen(),
    TasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,

        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: _buildNavIcon(
              context,
              assetPath: 'assets/images/home_icon.svg',
              index: 0,
            ),
          ),
          BottomNavigationBarItem(
            label: 'To Do',
            icon: _buildNavIcon(
              context,
              assetPath: 'assets/images/todo_icon.svg',
              index: 1,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Completed',
            icon: _buildNavIcon(
              context,
              assetPath: 'assets/images/completed_icon.svg',
              index: 2,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: _buildNavIcon(
              context,
              assetPath: 'assets/images/profile_icon.svg',
              index: 3,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _screen[_currentIndex],
      ),
    );
  }

  Widget _buildNavIcon(
    BuildContext context, {
    required String assetPath,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final color = isSelected
        ? const Color(0xFF15B86C)
        : isDark
        ? const Color(0xFFC6C6C6)
        : const Color(0xFF3A4640);

    return SvgPicture.asset(
      assetPath,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
