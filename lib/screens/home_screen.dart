import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController youtubeUrlController = TextEditingController();
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController!.dispose();
    super.dispose();
  }

  Future<void> _addSong(BuildContext context) async {
    String youtubeUrl = youtubeUrlController.text;

    // Ekstrak informasi dari URL YouTube
    try {
      var videoId = YoutubePlayer.convertUrlToId(youtubeUrl);
      var extractor = yt.YoutubeExplode();
      var video = await extractor.videos.get(videoId!);

      // Dapatkan judul dan artis
      String title = video.title;
      String artist = video.author;

      // Simpan data ke Firestore
      await FirebaseFirestore.instance.collection('songs').add({
        'title': title,
        'artist': artist,
        'youtubeUrl': youtubeUrl,
      });

      // Berhasil menambahkan lagu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lagu berhasil ditambahkan ke Firestore!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Bersihkan input fields setelah ditambahkan
      youtubeUrlController.clear();
    } catch (e) {
      // Gagal menambahkan lagu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan lagu: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Lagu dari YouTube'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: youtubeUrlController,
              decoration: InputDecoration(
                labelText: 'URL YouTube',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _addSong(context),
              child: Text('Tambah Lagu'),
            ),
          ],
        ),
      ),
    );
  }
}
