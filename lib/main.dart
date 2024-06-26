import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tunemix_apps/firebase_options.dart';
import 'package:tunemix_apps/screens/home_screen.dart';
import 'package:tunemix_apps/screens/login_screen.dart';
import 'package:tunemix_apps/screens/landing_screen.dart';
import 'package:tunemix_apps/screens/signup_screen.dart';
import 'package:tunemix_apps/screens/story_list_screen.dart';
import 'package:tunemix_apps/screens/user_profile_screen.dart';
import 'package:tunemix_apps/screens/view_profile_screen.dart';
import 'package:tunemix_apps/widgets/newsong.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TuneMix',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: NewSongScreen(),
        initialRoute: '/',
        routes: {
          '/landing': (context) => const LandingScreen(),
          '/account': (context) => const UserProfile(
                imageUrl: '',
                userName: '',
              ),
          '/view': (context) => const ViewProfile(
                userName: '',
                imageUrl: '',
              ),
          '/signup': (context) => const SignupScreen(),
          '/login': (context) => const LoginScreen(),
        });
  }
}
