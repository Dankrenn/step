import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:step/classes/Complex.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Complex> complexes = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getComplexFirebase().then((value) {
      setState(() {
        complexes = value;
      });
    });
  }

  Future<List<Complex>> getComplexFirebase() async {
    List<Complex> complexs = [];
    QuerySnapshot querySnapshot = await _firestore.collection('Complex').get();
    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>;
      if (data['name'] != null && data['injuries'] != null && data['videoUrl'] != null) {
        Complex complex = Complex(
          name: data['name'].toString(),
          injuries: List<String>.from(data['injuries'] as List<dynamic>),
          videoUrl: data['videoUrl'].toString(),
        );
        complexs.add(complex);
      }
    });
    return complexs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Комплексы'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: complexes.length,
          itemBuilder: (context, index) {
            Complex complex = complexes[index];
            String? videoId = complex.videoUrl != null ? YoutubePlayer.convertUrlToId(complex.videoUrl!) : null;

            YoutubePlayerController _controller = YoutubePlayerController(
              initialVideoId: videoId ?? '',
              flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );

            return Column(
              children: [
                Text(
                  complex.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  complex.injuries.join(', '),
                  style: TextStyle(fontSize: 20),
                ),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
