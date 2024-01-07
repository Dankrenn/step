import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step/classes/Question.dart';
import 'package:flutter/material.dart';



class Quest extends StatefulWidget {
  const Quest({Key? key});
  @override
  State<Quest> createState() => _QuestState();
}

class _QuestState extends State<Quest> {

     List<Question> listQuestion = [];
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

     @override
     void initState() {
       super.initState();
       getUserResponses().then((value) {
         if (value != null && value.length > 0) {
           setState(() {
             listQuestion = value;
           });
         } else {
           getQuestedFirebase().then((questions) {
             setState(() {
               listQuestion = questions;
             });
           });
         }
       });
     }


       Future<List<Question>> getQuestedFirebase() async {
       List<Question> questions = [];
       QuerySnapshot querySnapshot = await _firestore.collection('questions').get();
       querySnapshot.docs.forEach((doc) {
         var data = doc.data() as Map<String, dynamic>;
         if (data['question'] != null && data['answers'] != null) {
           Question question = Question(
             question: data['question'].toString(),
             answers: List<String>.from(data['answers'] as List<dynamic>),
           );
           questions.add(question);
         }
       });
       return questions;
     }



     Future<void> saveUserResponses(List<Question> questions) async {
       String userId = FirebaseAuth.instance.currentUser?.uid ?? 'default_uid';
       CollectionReference userResponses = _firestore.collection('user_responses').doc(userId).collection('responses');

       for (var question in questions) {
         await userResponses.doc(question.question).set({
           'question': question.question,
           'answers': question.answers,
           'userAnswerIndex': question.userAnswerIndex,
         });
       }
     }

     Future<List<Question>> getUserResponses() async {
       String userId = FirebaseAuth.instance.currentUser?.uid ?? 'default_uid';
       List<Question> userResponses = [];

       // Получение снимка коллекции 'responses' пользователя из Firestore
       QuerySnapshot responseSnapshot = await FirebaseFirestore.instance
           .collection('user_responses')
           .doc(userId)
           .collection('responses')
           .get();

       // Обработка каждого документа в снимке
       responseSnapshot.docs.forEach((doc) {
         var data = doc.data() as Map<String, dynamic>;

         // Проверка наличия необходимых полей
         if (data.containsKey('question') &&
             data.containsKey('answers') &&
             data.containsKey('userAnswerIndex')) {
           // Создание объекта Question
           Question question = Question(
             question: data['question'].toString(),
             answers: List<String>.from(data['answers'] as List<dynamic>),
             userAnswerIndex: data['userAnswerIndex'] as int,
           );

           // Добавление в список userResponses
           userResponses.add(question);
         }
       });

       return userResponses;
     }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Анкета'),
        ),
        body: Card(
          color: Colors.white60,
          child: ListView.builder(
            itemCount: listQuestion.length,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listQuestion[i].question,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    children: List.generate(listQuestion[i].answers.length, (int j)
                    {
                      return Row(
                        children: [
                          Radio(
                            value: j,
                            groupValue: listQuestion[i].userAnswerIndex,
                            onChanged: (int? value) {
                              setState(() {
                                listQuestion[i].userAnswerIndex = value!;
                              });
                            },
                          ),
                          Text(
                            listQuestion[i].answers[j],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  saveUserResponses(listQuestion);
                  Navigator.pushNamedAndRemoveUntil(context, '/Hub', (route) => false);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}