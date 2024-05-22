// song_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/song.dart';

class SongService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _songCollection = FirebaseFirestore.instance.collection('songs');

  Stream<List<Song>> getSongs() {
    return _songCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Song.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> addSong(Song song) async {
    await _songCollection.add({
      'title': song.title,
      'artist': song.artist,
      'youtube_link': song.youtubeLink,
    });
  }

  Future<void> updateSong(Song song) async {
    await _songCollection.doc(song.id).update({
      'title': song.title,
      'artist': song.artist,
      'youtube_link': song.youtubeLink,
    });
  }

  Future<void> deleteSong(String id) async {
    await _songCollection.doc(id).delete();
  }
}