import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddUserComplexScreen extends StatefulWidget {
  const AddUserComplexScreen({super.key});

  @override
  State<AddUserComplexScreen> createState() => _AddUserComplexScreenState();
}

class _AddUserComplexScreenState extends State<AddUserComplexScreen> {

  List<String> injuries = []; // Список травм

  TextEditingController complexNameController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();
  TextEditingController injuryController = TextEditingController();

  void addInjury() {
    setState(() {
      injuries.add(injuryController.text);
      injuryController.text = '';
    });
  }

  void removeInjury(int index) {
    setState(() {
      injuries.removeAt(index);
    });
  }

  Future<void> saveComplexData(String complexName, String videoLink, List<String> injuriesList) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'default_uid';
    String complexId = FirebaseFirestore.instance.collection('Complex').doc().id;
    DocumentReference complexDoc = FirebaseFirestore.instance.collection('Complex').doc(complexId);

    await complexDoc.set({
      'id': complexId,
      'name': complexName,
      'videoLink': videoLink,
      'injuries': injuriesList,
      'userId': userId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Создание комплекса'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: complexNameController,
              decoration: InputDecoration(
                labelText: 'Название комплекса',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: videoLinkController,
              decoration: InputDecoration(
                labelText: 'Ссылка на видео',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Травмы, которые решает комплекс:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: injuries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(injuries[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeInjury(index),
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: injuryController,
                    decoration: InputDecoration(
                      labelText: 'Новая травма',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addInjury,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String complexName = complexNameController.text;
                String videoLink = videoLinkController.text;
                List<String> injuriesList = injuries.toList();
                saveComplexData(complexName,videoLink,injuriesList);
                Navigator.pushNamedAndRemoveUntil(context, '/Hub', (route) => true);
              },
              child: Text('Сохранить комплекс'),
            ),
          ],
        ),
      ),
    );
  }
}
