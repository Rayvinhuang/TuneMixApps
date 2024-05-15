import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunemix_apps/screens/forgot_password_screen.dart';
import 'package:tunemix_apps/screens/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  String _loginError = '';
  bool rememberMe = false;
  bool _isLogin = false;
  bool _obscurePassword = true;
  String _usernameError = '';
  String _passwordError = '';

  // Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
  //     SharedPreferences sharedPreferences) async {
  //   final encryptedUsername = sharedPreferences.getString('Username') ?? '';
  //   final encryptedPassword = sharedPreferences.getString('Password') ?? '';
  //   final keyString = sharedPreferences.getString('key') ?? '';
  //   final ivString = sharedPreferences.getString('iv') ?? '';
  //   final encrypt.Key key = encrypt.Key.fromBase64(keyString);
  //   final encrypt.IV iv = encrypt.IV.fromBase64(ivString);
  //   final encrypter = encrypt.Encrypter(encrypt.AES(key));

  //   try {
  //     final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
  //     final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);
  //     return {'Username': decryptedUsername, 'Password': decryptedPassword};
  //   } catch (e) {
  //     print('An error occurred during decryption: $e');
  //     return {'Username': '', 'Password': ''};
  //   }
  // }


  bool isFieldsValid() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Future<void> _login() async {
    final String username = _usernameController.text.trim() + '@gmail.com';
    final String password = _passwordController.text.trim();


    if (username.isEmpty) {
    setState(() {
      _usernameError = 'Username is required'; 
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
      email: username,
      password: password,
    );

    // If login successful, navigate to home screen
    if (userCredential.user != null) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      // );
    } else {
      setState(() {
        _errorText = 'Invalid username or password';
      });
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      setState(() {
        _usernameError = 'Invalid username';
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
                            'Username',
                            style:
                                TextStyle(fontFamily: 'Belgrano', fontSize: 25),
                          ),
                          TextFormField(
                            controller: _usernameController,
                            cursorColor: const Color(0xFF000AFF),
                            decoration: InputDecoration(
                                errorText:_errorText == 'Username is required'
                            ? 'Username is required'
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
                            _usernameError,
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
