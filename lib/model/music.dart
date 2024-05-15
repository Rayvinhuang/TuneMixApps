import 'package:cloud_firestore/cloud_firestore.dart';

class Music{
  String? id;
  final String username;
  final String password;
  String? imageUrl;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Music({
    this.id,
    required this.username,
    required this.password,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Music.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Music(
      id: doc.id,
      username: data['username'],
      password: data['password'],
      imageUrl: data['image_url'],
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'password': password,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}