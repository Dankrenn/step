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
            photo: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAMM19ibc2ZGK72i5uLElaeQOu33N02S8xeQ&usqp=CAU'),
            username: 'fillset',
            message: 'Привет, как дела?',
            time: '10:30',
            unreadCount: 2,
          ),
          ChatTile(
            photo: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAMM19ibc2ZGK72i5uLElaeQOu33N02S8xeQ&usqp=CAU'),
            username: 'kyki',
            message: 'Привет, что нового?',
            time: '11:15',
            unreadCount: 0,
          ),
          ChatTile(
            username: 'salam',
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
