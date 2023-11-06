import 'package:flutter/material.dart';
import 'package:step/pages/Hub.dart';
import 'package:step/pages/Registr.dart';
import 'package:step/pages/Authorization.dart';
import 'package:step/pages/Quest.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(primaryColor: Colors.orange),
  initialRoute: '/Registr',
  routes: {
    '/Registr': (context) => Registr(),
    '/Authoriz': (context) => Authoriz(),
    '/Quest': (context) => Quest(),
    '/Hub': (context) => Hub(),
  },
));

