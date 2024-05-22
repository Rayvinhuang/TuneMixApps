import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:audioplayers/audioplayers.dart';

class NewSongScreen extends StatefulWidget {
  @override
  _NewSongScreenState createState() => _NewSongScreenState();
}

class _NewSongScreenState extends State<NewSongScreen> {
  final TextEditingController youtubeUrlController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  yt.YoutubeExplode _ytExplode = yt.YoutubeExplode();
  yt.Video? _video;
  String _videoTitle = '';
  String _videoAuthor = '';
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.COMPLETED) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _ytExplode.close();
    super.dispose();
  }

  Future<void> _addSong(BuildContext context) async {
    String youtubeUrl = youtubeUrlController.text;

    try {
      String videoId = _extractVideoId(youtubeUrl);

      var video = await _ytExplode.videos.get(videoId);

      setState(() {
        _video = video;
        _videoTitle = video.title;
        _videoAuthor = video.author;
      });

      await FirebaseFirestore.instance.collection('songs').add({
        'title': _videoTitle,
        'artist': _videoAuthor,
        'youtubeUrl': youtubeUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lagu berhasil ditambahkan ke Firestore!'),
          duration: Duration(seconds: 2),
        ),
      );

      youtubeUrlController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan lagu: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String _extractVideoId(String url) {
    var regExp = RegExp(r"(?:youtu\.be\/|youtube\.com(?:\/embed\/|\/v\/|\/watch\?v=|\/user\/\S+[^\/]\?v=))([^\/&\?]+)");
    var match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  Future<void> _playSongFromYoutube(BuildContext context) async {
    if (_video != null) {
      var manifest = await _ytExplode.videos.streamsClient.getManifest(_video!.id);

      var audioStream = manifest.audioOnly.last;
      String audioUrl = audioStream.url.toString();

      int result = await audioPlayer.play(audioUrl, isLocal: false);
      if (result == 1) {
        setState(() {
          _isPlaying = true;
        });
      }
    }
  }

  void _stopSong() {
    audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _goToSongList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SongListScreen()),
    );
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _goToSongList(context),
              child: Text('Lihat Daftar Lagu'),
            ),
            SizedBox(height: 16.0),
            if (_video != null)
              Column(
                children: [
                  Text(
                    '$_videoTitle - $_videoAuthor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          _playSongFromYoutube(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: () {
                          _stopSong();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    _isPlaying ? 'Sedang memutar' : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SongListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Lagu'),
      ),
      body: Center(
        child: Text('Daftar Lagu Akan Ditampilkan Di Sini'),
      ),
    );
  }
}
