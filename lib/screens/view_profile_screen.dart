import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunemix_apps/screens/favorite_screen.dart';
import 'package:tunemix_apps/screens/home_screen.dart';
import 'package:tunemix_apps/screens/search_screen.dart';
import 'package:tunemix_apps/screens/story_screen.dart';
import 'package:tunemix_apps/screens/user_profile_screen.dart';

import '../services/auth_service.dart';

class ViewProfile extends StatefulWidget {
  final String userName;
  final String imageUrl;

  const ViewProfile({Key? key, required this.userName, required this.imageUrl}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  int _currentIndex = 4;
  String userName = '';
  String _userName = 'Initial Username';
  bool isSignedIn = false;
  final TextEditingController _editedUserNameController = TextEditingController();
  int followersCount = 0;
  int followingCount = 0;
  bool isDarkMode = false;

  AuthService _authService = AuthService();
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _imageFile;
  File? _tempImageFile;
  String _tempUsername = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
     _getUserInfo();
  }

  void incrementFollowers(){
    setState(() {
      followersCount++;
    });
  }

  void incrementFollowing(){
    setState(() {
      followingCount++;
    });
  }

  void _signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        setState(() {
          isSignedIn = false;
        });
      } catch (e) {
        print('Error signing out: $e');
      }

      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });

      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, '/landing');
      });

      _loadUserData();
    }

  Future<void> choosePhoto(ImageSource source) async {
    await _authService.editPhoto(source);
    setState(() {
        _tempImageFile = _authService.imageFile;
    });
    Navigator.pop(context);
  }

  Future<void> _getUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Fetch username from Firestore
      DocumentSnapshot userInfo =
          await _database.collection('users').doc(user.uid).get();

      setState(() {
        _userName = userInfo['username'];
        _tempUsername = _userName; // Initialize temporary username
        _editedUserNameController.text = _userName; // Set text controller
      });
    }
  }

  
  Future<void> _updateUsername() async {
    String newUsername = _editedUserNameController.text.trim();
    // Panggil editUsername dari service Anda
    try {
      await AuthService().editUsername(newUsername);
      setState(() {
        _userName = newUsername;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update username: $e')),
      );
    }
  }

  Future<void> _loadUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userData.exists) {
          setState(() {
            String email = userData['username'];
            userName = email.split('@')[0];
            isSignedIn = true;
            _tempImageFile = userData['profileImageUrl'];
            followersCount = userData['followersCount'] ?? 0;
            followingCount = userData['followingCount'] ?? 0;
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _savePhoto() async {
    try {
      if (_tempImageFile != null) {
        await _authService.updateProfilePhoto(_tempImageFile!);
      }
    } catch (e) {
      print('Error saving photo: $e');
    }
  }

  void _showEditProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context);
      },
    );
  }

  void _showEditOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: SingleChildScrollView(
            child: _buildEditOptions(context),
          ),
        );
      },
    );
  }

  Widget _buildEditOptions(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    color: Colors.transparent,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            'CHANGE PROFILE PHOTO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Concert One',
            ),
          ),
        ),
        GestureDetector(
          onTap: ()=> choosePhoto(ImageSource.gallery),
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Choose from Library'),
                Divider(color: Colors.black),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => choosePhoto(ImageSource.camera),
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Take Photo'),
                Divider(color: Colors.black),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: ()  => _authService.removeCurrentPhoto(),
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Remove Current Photo'),
                Divider(color: Colors.black),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Itim',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget _buildBottomSheetContent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    height: 621,
    width: 399,
    color: const Color(0xFF525252).withOpacity(0.2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              'EDIT PROFILE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Concert One',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: ()  {
                 setState(() {
                    _imageFile = _tempImageFile;
                    _userName = _tempUsername; 
                  });
                  Navigator.pop(context);
              },
              child: const Text(
                'Save',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        const SizedBox(height: 10),
        
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child:  _tempImageFile == null
                        ? Image.network(
                            'https://images.unsplash.com/photo-1519283053578-3efb9d2e71bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxjYXJ0b29uJTIwcHJvZmlsZXxlbnwwfHx8fDE3MDI5MTExMzl8MA&ixlib=rb-4.0.3&q=80&w=1080',
                            fit: BoxFit.cover,
                          )
                        : Image.file(_tempImageFile!, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 83,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _showEditOptions(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Text(
              'USERNAME',
              style: TextStyle(
                fontFamily: 'Concert One',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _editedUserNameController,
                onChanged: (value) {
                  setState(() {
                    _tempUsername = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter new username',
                  hintStyle: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

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
                  Color(0xB97DAEA5),
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
                        child: _imageFile == null
                          ? Image.network(
                              'https://images.unsplash.com/photo-1519283053578-3efb9d2e71bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw4fHxjYXJ0b29uJTIwcHJvZmlsZXxlbnwwfHx8fDE3MDI5MTExMzl8MA&ixlib=rb-4.0.3&q=80&w=1080',
                              fit: BoxFit.cover,
                            )
                          : Image.file(_imageFile!, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_userName',
                              style: const TextStyle(
                                fontFamily: 'Inknut Antiqua',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  '$followersCount followers',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Inknut Antiqua',
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  '$followingCount following',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Inknut Antiqua',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showEditProfileBottomSheet(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fixedSize: const Size(69, 39),
                        ),
                        child: const Text(
                          'Edit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontFamily: 'Inknut Antiqua',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Tambahkan logika untuk dark mode di sini
                          setState(() {
                            // Tambahkan logika untuk mengubah warna lingkaran
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/darkmode.png',
                            color: Colors.black, // Sesuaikan warna ikon dengan logika dark mode
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          // Tambahkan logika untuk tombol Share di sini
                        },
                        icon: const Icon(
                          Icons.ios_share_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  //logout
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: ElevatedButton(
                      onPressed: () {
                        _signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: const Size(102, 34),
                      ),
                      child: const Text(
                        'Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Concert One',
                          fontSize: 18,
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
              _navigateToPage(index);
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
             // return const HomeScreen();
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
              return const UserProfile(
                imageUrl: '', userName: '',
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
