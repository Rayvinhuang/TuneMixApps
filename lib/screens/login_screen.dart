import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunemix_apps/screens/forgot_password_screen.dart';
import 'package:tunemix_apps/screens/home_screen.dart';
import 'package:tunemix_apps/screens/user_profile_screen.dart';

import '../services/auth_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  String _loginError = '';
  bool rememberMe = false;
  bool _isLogin = false;
  bool _obscurePassword = true;
  String _emailError = '';
  String _passwordError = '';

  final AuthService _authService = AuthService();
   final FirebaseFirestore _database = FirebaseFirestore.instance;

  bool isFieldsValid() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

   Future<void> _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _emailError;
      _passwordError;
      _errorText;
    });

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      return;
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan data pengguna di Firestore
      if (userCredential.user != null) {
        await _saveUserDataToFirestore(userCredential.user!);

        String userName = email.split('@')[0].replaceAll('.', '');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  UserProfile(imageUrl: '', userName: userName)),
        );
      } else {
        setState(() {
          _errorText = 'Invalid Email or Password';
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _emailError = 'Invalid Email';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _passwordError = 'Invalid password';
        });
      } else {
        setState(() {
          _errorText = 'An error occurred, please try again later';
        });
      }
    } catch (error) {
      print(error.toString());
      setState(() {
        _errorText = 'An error occurred, please try again later';
      });
    }
  }

   Future<void> _saveUserDataToFirestore(User user) async {
    try {
      String email = user.email ?? '';
      String userName = email.split('@')[0].replaceAll('.', '');
      DocumentReference userDocRef = _database.collection('users').doc(user.uid);

      await userDocRef.set({
        'userId': user.uid,
        'email': user.email ?? '',
        'username': userName,
      });
    } catch (e) {
      print('Error saving user data to Firestore: $e');
      throw e;
    }
  }

  void handleResetPassword(String newPassword) async {
    print('New Password: $newPassword');
  }

  void handleForgotPassword() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ForgotPasswordScreen(onUpdatePassword: handleResetPassword);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Align(
              alignment: const AlignmentDirectional(0.00, 0.00),
              child: Image.asset(
                'images/logo.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE7E7),
                  Color(0xD5F4D3D4),
                  Color(0x3D6C5278),
                  Color(0x9DD6EDB2),
                  Color(0xB97DAEA5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x004B39EF),
                          elevation: 0,
                          side: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        child: Image.asset('assets/images/arrowback.png',
                            width: 35, height: 35),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontFamily: 'Belgrano',
                          fontSize: 50.0,
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              offset: Offset(3, 2),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style:
                                TextStyle(fontFamily: 'Belgrano', fontSize: 25),
                          ),
                          TextFormField(
                            controller: _emailController,
                            cursorColor: const Color(0xFF000AFF),
                            decoration: InputDecoration(
                                errorText:_errorText == 'Email is required'
                            ? 'Email is required'
                            : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8FB2AD),
                                  width: 5.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8FB2AD),
                                  width: 5.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                          Text(
                            _emailError,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const Text(
                            'Password',
                            style:
                                TextStyle(fontFamily: 'Belgrano', fontSize: 25),
                          ),
                          TextFormField(
                            controller: _passwordController,
                            cursorColor: const Color(0xFF000AFF),
                            decoration: InputDecoration(
                              errorText:
                                 _passwordError.isNotEmpty ? _passwordError : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8FB2AD),
                                  width: 5.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8FB2AD),
                                  width: 5.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              suffixIcon: IconButton(
                                onPressed: _togglePasswordVisibility,
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            obscureText: _obscurePassword,
                          ),
                          Text(
                            _passwordError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                            checkColor: Colors.orange,
                            activeColor: Colors.green,
                            hoverColor: Colors.yellow,
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Text(
                        _loginError,
                        style: const TextStyle(color: Colors.red),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _login();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 44, 160, 135),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5.0,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontFamily: 'Belgrano', fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Forgot Password?',
                          style: const TextStyle(
                              fontFamily: 'InriaSans',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          mouseCursor: SystemMouseCursors.click,
                          recognizer: TapGestureRecognizer()
                            ..onTap = handleForgotPassword,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
