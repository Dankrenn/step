import 'package:flutter/material.dart';

import '../classes/ChatTile.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Чат пользователей'),
      ),
      body: ListView(
        children: [
          ChatTile(
            photo: Image.network('https://example.com/user1.jpg'),
            username: 'Пользователь 1',
            message: 'Привет, как дела?',
            time: '10:30',
            unreadCount: 2,
          ),
          ChatTile(
            photo: Image.network('https://example.com/user2.jpg'),
            username: 'Пользователь 2',
            message: 'Привет, что нового?',
            time: '11:15',
            unreadCount: 0,
          ),
          ChatTile(
            username: 'Пользователь 3',
            message: 'Привет, давно не виделись!',
            time: '12:00',
            unreadCount: 1,
          ),
          // Добавьте другие плитки чатов здесь
        ],
      ),
    );
  }
}
