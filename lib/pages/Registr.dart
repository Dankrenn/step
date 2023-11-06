import 'package:flutter/material.dart';

import '../classes/User.dart';

class Registr extends StatefulWidget {
  const Registr ({super.key});

  @override
  State<Registr> createState() => _RegistrState();
}

void RegistForms(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, '/Initial1', (route) => false);
}

User user1 = User();
late  String strpas;
class _RegistrState extends State<Registr> {
  @override
  Widget build(BuildContext context) =>
      SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(8, 70, 162, 1),
            body: Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: Column(
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Регистрация',
                        style: TextStyle(fontSize: 24, color: Colors.white60),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/Authoriz', (route) => false);},
                        child: Text(
                          'Авторизация',
                          style:
                          TextStyle(fontSize: 24, color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                    onChanged: (String value){ user1.Name = value;},
                          decoration: InputDecoration(
                            labelText: 'Имя',

                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String value){ user1.Email = value;},
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          onChanged: (String value){ user1.Password = value;},
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          onChanged: (String value){ strpas = value;},
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Повторите пароль',
                          ),
                        ),
                        SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          if (user1.Name != null ||
                              user1.Email != null ||
                              user1.Password != null) {
                            if (strpas != user1.Password) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white60,
                                  content: Text(
                                    'Ошибка: Пароли не совпадают!',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            } else {
                                  {Navigator.pushNamedAndRemoveUntil (context, '/Quest', (route) => true);}
                            }
                          } else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white60,
                                  content: Text('Ошибка: заполните все поля!', style: TextStyle(fontSize: 20, color: Colors.red ), ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            }
                          },
                          child: Text('Зарегистрироваться'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.green[600],
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      );
}

