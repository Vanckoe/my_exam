import 'package:flutter/material.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter_market/presentation/screen/animation.dart';
import 'package:flutter_market/presentation/screen/card_screen.dart';
import 'package:flutter_market/presentation/screen/qr.dart';
import 'package:flutter_market/presentation/screen/user_screen.dart';


class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UserPage(userEmail: 'rrrauka@mail.ru'),
    CardsPage(),
    Anime(),
    QRScanPage(),
    PageWidget('Settings Page', Colors.purple),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBarBubble(
        selectedIndex: _selectedIndex,
        onSelect: _onItemTapped,
        items: [
          BottomBarItem(iconData: Icons.home),
          BottomBarItem(iconData: Icons.chat),
          BottomBarItem(iconData: Icons.notifications),
          BottomBarItem(iconData: Icons.calendar_month),
          BottomBarItem(iconData: Icons.settings),
        ],
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final String title;
  final Color color;

  PageWidget(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
