import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      _database.collection('users');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _imageFile;
  File? get imageFile => _imageFile;

  Future<void> editUsername(String newUsername) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _database.collection('users').doc(user.uid).update({
          'username': newUsername,
        });
      }
    } catch (e) {
      print('Error editing username: $e');
      throw e;
    }
  }

  Future<void> editPhoto(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        await updateProfilePhoto(_imageFile!);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print("Error editing photo: $e");
      throw e;
    }
  }

  Future<void> updateProfilePhoto(File newPhoto) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String photoUrl = await _uploadImageToStorage(newPhoto);
        await user.updatePhotoURL(photoUrl);
        await _database.collection('users').doc(user.uid).update({
          'profileImageUrl': photoUrl,
        });
      }
    } catch (e) {
      print("Error updating profile photo: $e");
      throw e;
    }
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      String userId = _auth.currentUser!.uid;
      String fileName = '$userId${path.extension(imageFile.path)}';
      Reference ref = _storage.ref().child('profile_images/$fileName');
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
        final ref = _storage.ref('profile_images/${currentUser.uid}');
        await ref.delete();
        await _database.collection('users').doc(currentUser.uid).update({
          'profileImageUrl': FieldValue.delete(),
        });
      }
    } catch (error) {
      print('Error removing photo: $error');
    }
  }

  Future<void> _saveUserDataToFirestore(User user) async {
    try {
      DocumentReference userDocRef = _database.collection('users').doc(user.uid);

      await userDocRef.set({
        'userId': user.uid,
        'email': user.email ?? '',
      });
    } catch (e) {
      print('Error saving user data to Firestore: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await _database.collection('users').doc(user.uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('User data not found in Firestore');
        return null;
      }
    } else {
      print('User not logged in');
      return null;
    }
  }

  static Future<QuerySnapshot> retrieveProfile() {
    return _userCollection.get();
  }

  static Stream<List<Map<String, dynamic>>> getProfileList() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }
}