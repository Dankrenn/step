import 'package:flutter/material.dart';

class Authoriz extends StatefulWidget {
  const Authoriz ({super.key});

  @override
  State<Authoriz> createState() => _AuthorizState();
}

void initState() {

}

class _AuthorizState extends State<Authoriz> {
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
                      onPressed: (){Navigator.pushNamedAndRemoveUntil(context, '/Registr', (route) => false);},
                      child: Text(
                        'Регистрация',
                        style: TextStyle(fontSize: 24, color: Colors.blueGrey),
                      ),
                    ),
                    TextButton(
                      onPressed: (){},
                      child: Text(
                        'Авторизация',
                        style:
                        TextStyle(fontSize: 24, color: Colors.white60),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                        ),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/Hub', (route) => false);
                          },
                        child: Text('Войти'),
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