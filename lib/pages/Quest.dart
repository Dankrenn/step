import 'package:step/classes/Question.dart';
import 'package:flutter/material.dart';



class Quest extends StatefulWidget {
  const Quest({Key? key});

  @override
  State<Quest> createState() => _QuestState();
}

class _QuestState extends State<Quest> {
  List<Question> listQuestion = [
    Question(
      question: 'Вопрос 1',
      answers: ['Ответ 1', 'Ответ 2', 'Ответ 3'],
    ),
    Question(
      question: 'Вопрос 2',
      answers: ['Ответ 1', 'Ответ 2', 'Ответ 3'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Анкета'),
          centerTitle: true,
        ),
        body: Card(
          color: Colors.white60,
          child: ListView.builder(
            itemCount: listQuestion.length,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                children: [
                  Text(
                    listQuestion[i].question,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listQuestion[i].answers.length,
                    itemBuilder: (BuildContext context, int j) {
                      return Row(
                        children: [
                          Checkbox(
                            value: listQuestion[i].userAnswers[j] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                listQuestion[i].userAnswers[j] = value;
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
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            List<List<bool?>> userResponses = [];
            for (var question in listQuestion) {
              userResponses.add(question.userAnswers);
            }
            Navigator.pushNamedAndRemoveUntil (context, '/Hub', (route) => true);
            // Здесь вы можете провести анализ ответов пользователя, используя список userResponses
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}