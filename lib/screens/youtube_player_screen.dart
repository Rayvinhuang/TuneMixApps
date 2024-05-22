import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final TextEditingController youtubeUrlController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  Stream<QuerySnapshot>? songsStream;

  @override
  void initState() {
    super.initState();
    loadSongs();
  }

  void loadSongs() {
    songsStream = FirebaseFirestore.instance.collection('songs').snapshots();
  }


void playSong(String url) async {
  if (url.isNotEmpty) {
    try {
      // Download the audio file to local storage
      String localPath = await downloadFile(url);

      // Play the downloaded file
      int result = await audioPlayer.play(localPath, isLocal: true);
      if (result == 1) {
        print('Playing');
      } else {
        print('Failed to play');
      }

      // Listen to player state changes
      audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        if (state == PlayerState.completed) {
          print('Playback completed');
          // Optionally, you can stop playback here
          audioPlayer.stop();
        }
      });
    } catch (e) {
      print('Failed to download and play audio: $e');
    }
  }
}

  Future<String> downloadFile(String url) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');
    if (file.existsSync()) {
      await file.delete();
    }
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .writeToFile(file);
    return file.path;
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Lagu'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: songsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada lagu.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var song = snapshot.data!.docs[index];
              return ListTile(
                title: Text(song['title']),
                subtitle: Text(song['artist']),
                onTap: () {
                  playSong(song['youtubeUrl']);
                },
              );
            },
          );
        },
      ),
    );
  }
}
