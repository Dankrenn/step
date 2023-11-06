import 'package:flutter/material.dart';
import '../classes/Complex.dart';



class HomeScreen extends StatelessWidget {
  List<Complex> complexes = [
    Complex(
      name: 'Комплекс 1',
      injuries: ['Травма 1', 'Травма 2'],
    ),
    Complex(
      name: 'Комплекс 2',
      injuries: ['Травма 3', 'Травма 4'],
    ),
    // Добавьте другие комплексы
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 70, 162, 1),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: complexes.length,
          itemBuilder: (context, index) {
            Complex complex = complexes[index];
            return Row(
              children: [
                Column(children: [
                  Text(
                    complex.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    complex.injuries.join(', '),
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
                Padding(padding: EdgeInsets.all(30.0),),
                Container(
                  height: 150,
                  width: 150,
                  color: Colors.blueAccent,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}