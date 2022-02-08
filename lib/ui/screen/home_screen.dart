import 'package:flutter/material.dart';
import 'package:places/app.dart';
import 'package:places/ui/const/app_icons.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/widget/bottom_nav_bar.dart';
import 'package:places/ui/widget/empty_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      // ignore: no-empty-block
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SightListScreen(),
          EmptyList(
            icon: AppIcons.error,
            title: 'Карта',
            details: 'Не реализовано',
          ),
          VisitingScreen(),
          EmptyList(
            icon: AppIcons.error,
            title: 'Настройки',
            details: 'Не реализовано',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(Theme.of(context).brightness == Brightness.light
            ? 'Dark'
            : 'Light'),
        onPressed: () {
          App.of(context)?.toggleTheme();
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _tabController.index,
        onTap: _tabController.animateTo,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
