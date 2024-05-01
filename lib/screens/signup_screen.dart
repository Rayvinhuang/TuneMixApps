import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunemix_apps/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cfPasswordController = TextEditingController();

  String _errorText = '';
  bool _obscurePassword = true;

  Future<void> _signUp() async {
    final String fName = _fNameController.text.trim();
    final String lName = _lNameController.text.trim();
    final String username = _usernameController.text.trim() + '@gmail.com';
    final String password = _passwordController.text.trim();
    final String cfPw = _cfPasswordController.text.trim();

    //reset error text
     setState(() {
      _errorText = '';
    });

    // Validasi password
    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _errorText =
            'Minimal 8 karakter, kombinasi [A-Z], [a-z], [0-9], [!@#\$%^&*()]';
      });
      return;
    }

    // Validasi konfirmasi password
    if (cfPw != password) {
      setState(() {
        _errorText = 'Kata Sandi Tidak Sama';
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);

      // Simpan data pengguna di Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'first_name': fName,
        'last_name': lName,
        'username': _usernameController.text.trim(),
      });

      Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (error) {
      print(error.toString()); 
    }
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _cfPasswordController.dispose();
    super.dispose();
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
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE7E7),
                  Color(0xD5F4D3D4),
                  Color(0x3D6C5278),
                  Color(0x9DD6EDB2),
                  Color(0xB97DAEA5),
                ],
                stops: [0, 0.2, 0.5, 0.8, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 65),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontFamily: 'Belgrano',
                            fontSize: 40,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                offset: Offset(3, 2),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name',
                              style: TextStyle(
                                  fontFamily: 'Belgrano', fontSize: 20),
                            ),
                            TextFormField(
                              cursorColor: const Color(0xFF000AFF),
                              controller: _fNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                  fontFamily: 'Belgrano', fontSize: 20),
                            ),
                            TextFormField(
                              cursorColor: const Color(0xFF000AFF),
                              controller: _lNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Username',
                              style: TextStyle(
                                  fontFamily: 'Belgrano', fontSize: 20),
                            ),
                            TextFormField(
                              cursorColor: const Color(0xFF000AFF),
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Password',
                              style: TextStyle(
                                  fontFamily: 'Belgrano', fontSize: 20),
                            ),
                            TextFormField(
                              cursorColor: const Color(0xFF000AFF),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                errorText:
                                    _errorText.isNotEmpty ? _errorText : null,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
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
                            const SizedBox(height: 10),
                            const Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontFamily: 'Belgrano', fontSize: 20),
                            ),
                            TextFormField(
                              cursorColor: const Color(0xFF000AFF),
                              controller: _cfPasswordController,
                              decoration: InputDecoration(
                                errorText:
                                    _errorText.isNotEmpty ? _errorText : null,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                    color: Color(0xFF8FB2AD),
                                    width: 5.0,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
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
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _signUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 44, 160, 135),
                                  shape: const ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  elevation: 5.0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 40),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontFamily: 'Belgrano', fontSize: 25),
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
            ),
          ),
        ],
      ),
    );
  }
}
