
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:step/pages/AddUserComplexScreen.dart';
import 'package:step/pages/HomeScreen.dart';
import 'package:step/pages/Hub.dart';
import 'package:step/pages/Registr.dart';
import 'package:step/pages/Authorization.dart';
import 'package:step/pages/Quest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDnlO92AZQXwr1pOJfgN75TpO27tF8jEKA',
          appId: '1:561120459383:android:dfe6d34a6397c4d474a472',
          messagingSenderId: '561120459383' ,
          projectId: 'fir-step-f9a6a',
          storageBucket: 'fir-step-f9a6a.appspot.com'
      )

  );
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация Firebase и других сервисов
  await Firebase.initializeApp();

  // Проверка состояния аутентификации
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;

  MyApp({this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ваше приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: user != null ? Hub() : AuthorizationScreen(),
      routes: {
        '/Authoriz': (context) => AuthorizationScreen(),
        '/Hub': (context) => Hub(),
        '/Registr': (context) => RegistrationScreen(),
        '/Quest': (context) => Quest(),
        '/Hub': (context) => Hub(),
        '/AddComplex': (context) => AddUserComplexScreen(),
        // Другие маршруты
      },
    );
  }
}
