import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tunemix_apps/model/story.dart';

class StoryService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _storyCollection =
      _database.collection('stories');

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadImage(File imageFile) async {
    //klo upload berhasil maka ambil url dri storage, klo idk return null
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('images/$fileName');

      UploadTask uploadTask; //upload ke ref yg dituju
      if (kIsWeb) {
        uploadTask = ref.putData(await imageFile.readAsBytes());
      } else {
        uploadTask = ref.putFile(imageFile);
      }
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  static Future<void> addStory(Story story) async {
    Map<String, dynamic> newStory = {
      'title': story.title,
      'description': story.description,
      'image_url': story.imageUrl,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _storyCollection.add(newStory);
  }

  static Future<void> updateStory(Story story) async {
    Map<String, dynamic> updatedStory = {
      'title': story.title,
      'description': story.description,
      'image_url': story.imageUrl,
      'created_at': story.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
    };

    await _storyCollection.doc(story.id).update(updatedStory);
  }

  static Future<void> deleteStroy(Story story) async {
    await _storyCollection.doc(story.id).delete();
  }

  static Future<QuerySnapshot> retrieveStory() {
    return _storyCollection.get();
  }

  static Stream<List<Story>> getStoryList() {
    return _storyCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Story(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          imageUrl: data['image_url'],
          createdAt: data['created_at'] != null
              ? data['created_at'] as Timestamp
              : null,
          updatedAt: data['updated_at'] != null
              ? data['updated_at'] as Timestamp
              : null,
        );
      }).toList();
    });
  }

}