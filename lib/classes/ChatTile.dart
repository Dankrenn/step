import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final Image? photo;
  final String username;
  final String message;
  final String time;
  final int unreadCount;

  const ChatTile({
    this.photo,
    required this.username,
    required this.message,
    required this.time,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: photo != null
            ? ClipOval(
          child: SizedBox(
            width: 40,
            height: 40,
            child: photo,
          ),
        )
            : Text(
          username[0],
          style: TextStyle(fontSize: 20),
        ),
      ),
      title: Text(username),
      subtitle: Text(message),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time),
          if (unreadCount > 0)
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unreadCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
