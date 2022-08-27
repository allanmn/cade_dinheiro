import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppTheme.colors.primary,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        selectedItemColor: AppTheme.colors.secondary,
        unselectedItemColor: AppTheme.colors.light,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.wallet), label: 'Carteiras'),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.piggyBank),
            label: 'Orçamentos',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.arrowsRotate),
            label: 'Transações',
          )
        ],
        onTap: (index) => _incrementTab(index),
      ),
    );
  }
}
