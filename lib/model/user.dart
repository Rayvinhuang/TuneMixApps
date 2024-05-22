import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  String email;
  final String password;
  String? imageUrl;
  String role;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.role,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      email: data['email'],
      password: data['password'],
      imageUrl: data['image_url'],
      role: data['role'],
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'password': password,
      'image_url': imageUrl,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}