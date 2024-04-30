//import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunemix_apps/screens/favorite_screen.dart';
import 'package:tunemix_apps/screens/home_screen.dart';
import 'package:tunemix_apps/screens/search_screen.dart';
import 'package:tunemix_apps/screens/story_screen.dart';
import 'package:tunemix_apps/screens/view_profile_screen.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // late final Future<SharedPreferences> prefsFuture;
  // bool isSignedIn = true;
  // String fullName = '';
  // String userName = '';
  // int favoriteCandiCount = 0;
  int _currentIndex = 4;

  // @override
  // void initState() {
  //   super.initState();
  //   initialize();
  // }

  // void initialize() async {
  //   final SharedPreferences prefs = await prefsFuture;
  //   if (prefs.containsKey('key')) {
  //     String encryptedFullName = prefs.containsKey('fullname')
  //         ? prefs.getString('fullname') ?? ''
  //         : '';
  //     String encryptedUsername = prefs.getString('username') ?? '';

  //     final encrypt.Key key =
  //         encrypt.Key.fromBase64(prefs.getString('key') ?? '');
  //     final iv = encrypt.IV.fromBase64(prefs.getString('iv') ?? '');

  //     final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //     final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
  //     final decryptedFullname = encrypter.decrypt64(encryptedFullName, iv: iv);

  //     setState(() {
  //       isSignedIn = prefs.getBool('isSignedIn') ?? false;
  //       fullName = decryptedFullname;
  //       userName = decryptedUsername;
  //     });
  //   }
  // }

  // // TODO: 5. Implementasi fungsi signIn
  // void signIn() {
  //   // Perform your sign-in logic here
  //   // For example, you can show a sign-in dialog
  // }

  // // TODO: 6. Implementasi fungsi signOut
  // void signOut() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isSignedIn', false);
  //   prefs.setString('fullname', ' ');
  //   prefs.setString('username', '');
  //   prefs.setString('password', '');

  //   // Navigate back to the previous screen or any other logic you need
  //   Navigator.of(context).popUntil((route) => route.isFirst);
  //   Navigator.pushReplacementNamed(context, '/');
  // }

  bool isSignedIn = false;
  String userName = '';
  int favoriteCandiCount = 0;
  final TextEditingController _editedUserNameController =
      TextEditingController();

  // TODO: 5. Implementasi fungsi signIn
  // void signIn() {
  //   setState(() {
  //     isSignedIn = !isSignedIn;
  //   });
  // }

  //TODO: 6. Implementasi fungsi signOut
  // void signOut() {
  //   setState(() {
  //     isSignedIn = !isSignedIn;
  //   });
  // }

  @override
  void initState() {
    super.initState();
   // _loadUserData();
  }

  // _loadUserData() async {
  //   print('1');
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print('2');
  //   if (prefs.containsKey('key')) {
  //     print('3');

  //     String encryptedUserName = prefs.getString('Username') ?? '';

  //     print('4');
  //     final encrypt.Key key =
  //         encrypt.Key.fromBase64(prefs.getString('key') ?? '');
  //     final iv = encrypt.IV.fromBase64(prefs.getString('iv') ?? '');

  //     print('5');
  //     final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //     final decryptedUsername = encrypter.decrypt64(encryptedUserName, iv: iv);

  //     print('6');
  //     setState(() {
  //       print('7');
  //       isSignedIn = prefs.getBool('isSignedIn') ?? false;
  //       userName = decryptedUsername;
  //     });
  //   }
  // }

  void _signIn() {
    Navigator.pushNamed(context, '/signin');
  }

  void _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
    prefs.setString('userName', '');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacementNamed(context, '/landing');
    });

   // _loadUserData();
  }

  // void editUserName() async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Edit Nama'),
  //         content: TextField(
  //           controller: _editedUserNameController,
  //           decoration: const InputDecoration(labelText: 'Input nama'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               SharedPreferences prefs = await SharedPreferences.getInstance();
  //               if (_editedUserNameController.text.isNotEmpty &&
  //                   prefs.containsKey('key') &&
  //                   prefs.containsKey('iv')) {
  //                 final encrypt.Key key =
  //                     encrypt.Key.fromBase64(prefs.getString('key') ?? '');
  //                 final iv = encrypt.IV.fromBase64(prefs.getString('iv') ?? '');

  //                 final encrypter = encrypt.Encrypter(encrypt.AES(key));

  //                 final encryptedUserName = encrypter.encrypt(
  //                   _editedUserNameController.text,
  //                   iv: iv,
  //                 );

  //                 prefs.setString('Username', encryptedUserName.base64);

  //                 // Reload user data to update the state
  //                 _loadUserData();

  //                 Navigator.pop(context);
  //               }
  //             },
  //             child: const Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void signOut() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isSignedIn', false);
  //   prefs.remove('Username');
  //   prefs.remove('key');
  //   prefs.remove('iv');

  //   Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);

  //   setState(() {
  //     userName = '';
  //   });
  // }

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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE7E7),
                  Color(0xD5F4D3D4),
                  Color(0x3D6C5278),
                  Color(0x9DD6EDB2),
                  Color(0xB97DAEA5)
                ],
                stops: [0, 0.2, 0.5, 0.8, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            alignment: const AlignmentDirectional(0, -1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 80, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1519283053578-3efb9d2e71bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxjYXJ0b29uJTIwcHJvZmlsZXxlbnwwfHx8fDE3MDI5MTExMzl8MA&ixlib=rb-4.0.3&q=80&w=1080',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontFamily: 'Inknut Antiqua', 
                                fontWeight: FontWeight.bold, 
                                fontSize:  20),
                            ),
                            const SizedBox(height: 2),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViewProfile()), 
                                );
                              },
                              child: const Text(
                                'View Profile',
                                style: TextStyle(
                                  fontFamily: 'Inria Sans', fontSize: 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expanded(
                      //   child: Align(
                      //     alignment: AlignmentDirectional(1, 0),
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         signOut();
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.black,
                      //         padding: const EdgeInsetsDirectional.fromSTEB(
                      //             24, 0, 24, 0),
                      //         elevation: 3,
                      //         side: const BorderSide(
                      //           color: Color(0xFF8E00FF),
                      //           width: 1,
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         'Sign Out',
                      //         style: TextStyle(
                      //           fontFamily: 'Readex Pro',
                      //           color: Colors.white,
                      //           fontSize: 10,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/history');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Listening History',
                              style:
                                  TextStyle(fontFamily: 'Itim', fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/story');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child:  Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'images/story.png',
                              width: 24,
                              height: 24,
                            ),
                           const SizedBox(width: 5),
                            const Text(
                              'Your Story',
                              style:
                                  TextStyle(fontFamily: 'Itim', fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/library');
                      },
                      child: const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.library_music,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Your Library',
                              style:
                                  TextStyle(fontFamily: 'Itim', fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromARGB(255, 214, 240, 238),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
             // _navigateToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0
                    ? Colors.deepPurple
                    : const Color.fromARGB(255, 48, 162, 159),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _currentIndex == 1
                    ? Colors.deepPurple
                    : const Color.fromARGB(255, 48, 162, 159),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 2
                    ? 'images/story.png'
                    : 'images/story.png',
                  width: 24,
                  height: 24,
                  color: _currentIndex == 2
                      ? Colors.deepPurple
                      : const Color.fromARGB(255, 48, 162, 159),
              ),
              label: 'Story',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _currentIndex == 3
                    ? Colors.deepPurple
                    : const Color.fromARGB(255, 48, 162, 159),
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                color: _currentIndex == 4
                    ? Colors.deepPurple
                    : const Color.fromARGB(255, 48, 162, 159),
              ),
              label: 'Account',
            ),
          ],
          showUnselectedLabels: false,
          showSelectedLabels: false,
        ),
      ),
    );
  }


  void _navigateToPage(int index) {
    var routeBuilder;
    switch (index) {
      case 0:
        routeBuilder = '/home';
        break;
      case 1:
        routeBuilder = '/search';
        break;
      case 2:
        routeBuilder = '/podcast';
        break;
      case 3:
        routeBuilder = '/fav';
        break;
      case 4:
        routeBuilder = '/account';
        break;
    }

    if (index == 2) {
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const StoryScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              var tween = Tween(begin: begin, end: end);

              var fadeOutAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: fadeOutAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ));
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          switch (index) {
            case 0:
              return const HomeScreen();
            case 1:
              return const SearchScreen();
            case 2:
              return const StoryScreen();
            case 3:
              return const FavoriteScreen(
               // favoriteSongs: [],
              //  favoritePodcasts: [],
              );
            case 4:
              return const UserProfile();
            default:
              return Container();
          }
        },
      ),
    );
  }
}