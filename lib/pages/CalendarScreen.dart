
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../classes/Notifications.dart';
import 'package:timezone/timezone.dart'as tz;


class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now(); // Initialize _selectedDay
  String title = ''; // Initialize title
  String description = ''; // Initialize description
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay? selectedTime;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Инициализация настроек уведомлений
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =  DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }


  void _scheduleNotification(String notificationId, String title, String description, DateTime dateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      channelDescription: 'your_channel_description',
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      int.parse(notificationId),
      title,
      description,
      tz.TZDateTime.from(dateTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'custom notification payload',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }



  void _selectTime(BuildContext context) async {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime!;
      });
    }
  }

  void _saveNotificationToFirestore(String title, String description, DateTime selectedDate, TimeOfDay selectedTime) {
    DateTime notificationDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    FirebaseFirestore.instance.collection('notifications').add({
      'title': title,
      'description': description,
      'date': selectedDate,
      'notification_time': notificationDateTime,
    }).then((value) {
      print("Notification added successfully with ID: ${value.id}");
      // Вызов функции для запланированного уведомления
      _scheduleNotification(value.id, title, description, notificationDateTime);
    }).catchError((error) {
      print("Failed to add notification: $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Календарь'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2023, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
          // _showEventInfo(context, _selectedDay);
        },
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEventInfo(context, _selectedDay);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEventInfo(BuildContext context, DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Добавить напоминание'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Заголовок',
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Текст уведомления',
                ),
              ),
              ListTile(
                title: Text('Выберите время уведомления'),
                onTap: () {
                  _selectTime(context);
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _saveNotificationToFirestore(title,description,_selectedDay,selectedTime!);
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}
