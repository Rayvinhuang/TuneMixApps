import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunemix_apps/screens/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final Function(String) onUpdatePassword;

  ForgotPasswordScreen({required this.onUpdatePassword});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showWarning = false;
  bool _isButtonDisabled = true;
  bool _obscurePassword = true;

void _updatePassword(String newPassword) async {
    try {
      // Dapatkan pengguna saat ini
      User? user = FirebaseAuth.instance.currentUser;

      // Ubah kata sandi pengguna
      await user?.updatePassword(newPassword);

      // Panggil fungsi onUpdatePassword untuk memberitahu penggunaan password telah diubah
      widget.onUpdatePassword(newPassword);

      // Tampilkan dialog sukses
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Password Updated"),
            content: Text("Password updated successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Tampilkan pesan error jika terjadi kesalahan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }


  void _resetPassword() {
    if (newPasswordController.text == confirmPasswordController.text) {
      _updatePassword(newPasswordController.text);
    } else {
      setState(() {
        showWarning = true;
      });
    }
  }

  bool isFieldsValid() {
    return newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text;
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
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontFamily: 'Belgrano',
                    fontSize: 30.0,
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
                const Text(
                  'New Password',
                  style: TextStyle(fontFamily: 'Belgrano', fontSize: 25),
                ),
                TextField(
                  controller: newPasswordController,
                  obscureText: _obscurePassword,
                  onChanged: (value) {
                    setState(() {
                      _isButtonDisabled = value.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
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
                ),
                const SizedBox(height: 10),
                const Text(
                  'Confirm Password',
                  style: TextStyle(fontFamily: 'Belgrano', fontSize: 25),
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: _obscurePassword,
                  onChanged: (value) {
                    setState(() {
                      _isButtonDisabled = value.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
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
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: isFieldsValid() && !_isButtonDisabled
                          ? _resetPassword
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92B576),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5.0,
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontFamily: 'InriaSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    if (showWarning)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Please Fill in All Fields and Make Sure New and Confirm Password Match.',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'InriaSans',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92B576),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5.0,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'InriaSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
