import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Update nama pengguna
  Future<void> updateUserName(String newName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(newName);
        await _firestore.collection('users').doc(user.uid).update({
          'username': newName,
        });
      }
    } catch (e) {
      print("Error updating username: $e");
      throw e;
    }
  }

  // Update foto profil
  Future<void> updateProfilePhoto(File newPhoto) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String photoUrl = await _uploadImageToStorage(newPhoto, user.uid);
        await user.updatePhotoURL(photoUrl);
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': photoUrl,
        });
      }
    } catch (e) {
      print("Error updating profile photo: $e");
      throw e;
    }
  }

  // Upload foto ke Firebase Storage dan dapatkan URL-nya
  Future<String> _uploadImageToStorage(File imageFile, String userId) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('user_photos').child(userId);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image to storage: $e");
      throw e;
    }
  }

   Future<void> removeCurrentPhoto() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Mendapatkan referensi foto dari Firebase Storage
        final ref = _storage.ref('profile_images/${currentUser.uid}');

        // Menghapus foto dari Firebase Storage
        await ref.delete();
      }
    } catch (error) {
      print('Error removing photo: $error');
    }
  }
}
