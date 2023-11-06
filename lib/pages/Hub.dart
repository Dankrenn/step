import 'package:flutter/material.dart';
class Hub extends StatefulWidget {
  const Hub({super.key});

  @override
  State<Hub> createState() => _HubState();
}

class _HubState extends State<Hub> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Step',
            style: TextStyle(fontSize: 24, color: Colors.white60),
          ),
          backgroundColor: Color.fromRGBO(8, 70, 162, 1),
          centerTitle: true,
        ),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
