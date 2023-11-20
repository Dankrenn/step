import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  _AuthorizState createState() => _AuthorizState();
}

class _AuthorizState extends State<AuthorizationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  void login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Если аутентификация прошла успешно, переходим на другой экран
      Navigator.pushNamedAndRemoveUntil(context, '/Hub', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBar(
          content: Text(
            'Неправильный Email или пароль',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          duration: Duration(seconds: 5),
        );
      }
    }
  }
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Авторизация'),
          centerTitle: true,
        ),
        body: Padding(
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
                    obscureText: !showPassword,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
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
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/Registr', (route) => true);
                    },
                    child: Text(
                      'Еще нет аккаунта?',
                      style: TextStyle(
                        color: Colors.blueAccent,
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
