import 'package:flutter/material.dart';
import '../classes/User.dart';
import '../classes/EmailValidator.dart';


class Registr extends StatefulWidget {
  const Registr({Key? key});

  @override
  _RegistrState createState() => _RegistrState();
}

class _RegistrState extends State<Registr> {
  final user = User();
  String confirmPassword = '';
  bool isEmailValid = true;

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  void register(BuildContext context) {
    if (user.name.isEmpty || user.email.isEmpty || user.password.isEmpty || confirmPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(
    'Ошибка: Заполните все поля!',
    style: TextStyle(fontSize: 20, color: Colors.red),
    ),
    duration: Duration(seconds: 5),
    ),
    );
    } else if (user.password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(
    'Ошибка: Пароли не совпадают!',
    style: TextStyle(fontSize: 20, color: Colors.red),
    ),
    duration: Duration(seconds: 5),
    ),
    );
    } else if (!isEmailValid) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(
    'Ошибка: Неправильный формат email!',
    style: TextStyle(fontSize: 20, color: Colors.red),
    ),
    duration: Duration(seconds: 5),
    ),
    );
    } else {
      Navigator.pushNamedAndRemoveUntil (context, '/Quest', (route) => true);
    // Продолжайте с регистрацией пользователя
    // ...
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 70, 162, 1),
      appBar: AppBar(
        title: Text('Регистрация'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              onChanged: (String value) {
                setState(() {
                  user.name = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Имя',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  user.email = value;
                  isEmailValid = validateEmail(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: isEmailValid ? null : 'Неправильный формат email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (String value) {
                setState(() {
                  user.password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (String value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Повторите пароль',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text('Зарегистрироваться'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.green[600],
                padding:
                EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

