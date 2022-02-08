import 'package:flutter/material.dart';
import './tab_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabsScreenState();
  }
}

class TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> tabs = [
    {
      'name': 'Tab 1',
      'icondata': Icons.school,
      'tabscreen': TabScreen(1),
    },
    {
      'name': 'Tab 2',
      'icondata': Icons.book_online,
      'tabscreen': TabScreen(2),
    },
    {
      'name': 'Tab 3',
      'icondata': Icons.settings,
      'tabscreen': TabScreen(3),
    },
  ];
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex]['tabscreen'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: tabs
            .map((tabInfo) => BottomNavigationBarItem(
                  label: tabInfo['name'],
                  icon: Icon(tabInfo['icondata']),
                ))
            .toList(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
