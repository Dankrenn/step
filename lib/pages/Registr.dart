import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../classes/EmailValidator.dart';
import '../classes/User.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserApp _user = UserApp();

  bool _isEmailValid = true;
  String _confirmPassword = '';
  bool showPassword1 = false;
  bool showPassword2 = false;

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  void _registerUser(BuildContext context) async {
    if (_user.password != _confirmPassword) {
      _showSnackBar(context, 'Ошибка: Пароли не совпадают!');
    } else if (!_isEmailValid) {
      _showSnackBar(context, 'Ошибка: Неправильный формат email!');
    } else {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _user.email,
          password: _user.password,
        );

        User? firebaseUser = userCredential.user;
        if (firebaseUser != null) {
          await firebaseUser.updateProfile(displayName: _user.name);
          Navigator.pushNamedAndRemoveUntil(context, '/Quest', (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showSnackBar(context, 'Ошибка: Слишком слабый пароль!');
        } else if (e.code == 'email-already-in-use') {
          _showSnackBar(context, 'Ошибка: Учетная запись уже существует для этого email!');
        }
      } catch (e) {
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onChanged: (value) {
                setState(() {
                  _user.name = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Имя',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _user.email = value;
                  _isEmailValid = validateEmail(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _isEmailValid ? null : 'Неправильный формат email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              obscureText: !showPassword1,
              onChanged: (value) {
                setState(() {
                  _user.password  = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Пароль',
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword1 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword1 = !showPassword1;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              obscureText: !showPassword2,
              onChanged: (value) {
                setState(() {
                  _confirmPassword  = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Повторите пароль',
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword2 = !showPassword2;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => _registerUser(context),
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
    );
  }
}


