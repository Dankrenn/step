import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'ProfileScreen.dart';
class Hub extends StatefulWidget {
  const Hub({Key? key});
  @override
  State<Hub> createState() => _HubState();
}
class _HubState extends State<Hub> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(8, 70, 162, 1),
        appBar: AppBar(
          title: Text('Комплексы'),
          centerTitle: true,
        ),
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Чат',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Чат пользователей'),
    );
  }
}
