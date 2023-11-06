import 'package:flutter/material.dart';

class Authoriz extends StatefulWidget {
  const Authoriz({Key? key}) : super(key: key);

  @override
  _AuthorizState createState() => _AuthorizState();
}

class _AuthorizState extends State<Authoriz> {
  String email = '';
  String password = '';

  void login(BuildContext context) {
    // Проверка пользователя
    if (email == 'daniilruzenko@gmail.com' && password == '1') {
      Navigator.pushNamedAndRemoveUntil(context, '/Hub', (route) => true);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка'),
            content: Text('Неправильный email или пароль.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Авторизация'),
          centerTitle: true,
        ),
        backgroundColor: Color.fromRGBO(8, 70, 162, 1),
        body:Padding(
          padding: EdgeInsets.all(22.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: Text('Войти'),
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
            ],
          ),
        ),
      ),
    );
  }
}
