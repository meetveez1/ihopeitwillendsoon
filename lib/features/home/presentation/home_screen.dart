import 'package:flutter/material.dart';

import '../../news/presentation/news_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../schedule/presentation/schedule_screen.dart';
import '../../settings/presentation/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    const pages = [NewsScreen(), ScheduleScreen(), ProfileScreen(), SettingsScreen()];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'Новости'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Расписание'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}
