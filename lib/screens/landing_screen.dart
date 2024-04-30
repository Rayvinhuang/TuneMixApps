import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:tunemix_apps/screens/ct_google.dart';
import 'package:tunemix_apps/screens/login_screen.dart';
import 'package:tunemix_apps/screens/signup_screen.dart';

//import '../auth/signup_screens.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0.0, 5.0 * _controller.value),
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'images/logo.png',
          width: 300,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        child: Container(
          height: double.infinity,
          padding:
              const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
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
          child: Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(),
                    Text(
                      'Million of Songs\n Free on TuneMix',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Belgrano',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 20, right: 20, bottom: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SignupScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = 0.0;
                                const end = 1.0;
                                const curve = Curves.easeInOut;

                                var scaleTween = Tween(begin: begin, end: end);
                                var fadeTween = Tween(begin: 0.0, end: 1.0);

                                var curvedAnimation = CurvedAnimation(
                                  parent: animation,
                                  curve: curve,
                                );

                                var scaleAnimation =
                                    scaleTween.animate(curvedAnimation);
                                var fadeAnimation =
                                    fadeTween.animate(curvedAnimation);

                                return ScaleTransition(
                                  scale: scaleAnimation,
                                  child: FadeTransition(
                                    opacity: fadeAnimation,
                                    child: child,
                                  ),
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xB957D0CA),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text(
                            'Sign Up for Free',
                            style: TextStyle(
                              fontFamily: 'HoltwoodOneSC',
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const ContinueWithGoogle(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = 0.0;
                                const end = 1.0;
                                const curve = Curves.easeInOut;

                                var scaleTween = Tween(begin: begin, end: end);
                                var fadeTween = Tween(begin: 0.0, end: 1.0);

                                var curvedAnimation = CurvedAnimation(
                                  parent: animation,
                                  curve: curve,
                                );

                                var scaleAnimation =
                                    scaleTween.animate(curvedAnimation);
                                var fadeAnimation =
                                    fadeTween.animate(curvedAnimation);

                                return ScaleTransition(
                                  scale: scaleAnimation,
                                  child: FadeTransition(
                                    opacity: fadeAnimation,
                                    child: child,
                                  ),
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF101213),
                          textStyle: const TextStyle(
                            fontFamily: 'Itim',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          side: const BorderSide(
                            color: Color.fromARGB(184, 224, 224, 224),
                            width: 3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/google.png',
                                width: 20, height: 20),
                            const SizedBox(width: 10),
                            const Text('Continue with Google'),
                          ],
                        ),
                      ),
                    ),
        

                    Align(
                      alignment: const AlignmentDirectional(-1.00, 0.00),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                  fontFamily: 'Bebas Neue',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign In',
                                style: const TextStyle(
                                  fontFamily: 'Bebas Neue',
                                  color: Color(0xFF4B39EF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                mouseCursor: SystemMouseCursors.click,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const LoginScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = 0.0;
                                          const end = 1.0;
                                          const curve = Curves.easeInOut;

                                          var scaleTween =
                                              Tween(begin: begin, end: end);
                                          var fadeTween =
                                              Tween(begin: 0.0, end: 1.0);

                                          var curvedAnimation = CurvedAnimation(
                                            parent: animation,
                                            curve: curve,
                                          );

                                          var scaleAnimation = scaleTween
                                              .animate(curvedAnimation);
                                          var fadeAnimation = fadeTween
                                              .animate(curvedAnimation);

                                          return ScaleTransition(
                                            scale: scaleAnimation,
                                            child: FadeTransition(
                                              opacity: fadeAnimation,
                                              child: child,
                                            ),
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
