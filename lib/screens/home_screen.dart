// import 'package:flutter/material.dart';
// // import 'package:tunemix/data/songs_data.dart';
// // import 'package:audioplayers/audioplayers.dart';
// import 'package:tunemix_apps/screens/story_screen.dart';
// import 'package:tunemix_apps/screens/user_profile_screen.dart';

// import 'favorite_screen.dart';
// import 'search_screen.dart';
// import 'user_profile_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   //late AudioPlayer _audioPlayer;
//   String _audioTitle = '';
//   Duration _audioDuration = const Duration();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _audioPlayer = AudioPlayer();
//   //   _audioPlayer.onDurationChanged.listen((Duration duration) {
//   //     setState(() {
//   //       _audioDuration = duration;
//   //     });
//   //   });

//   //   _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//   //     if (state == PlayerState.PLAYING) {
//   //       setState(() {
//   //         _audioTitle = 'Bruno Mars - Versace on the Floor';
//   //       });
//   //     } else if (state == PlayerState.PAUSED) {
//   //     } else if (state == PlayerState.STOPPED) {
//   //       setState(() {
//   //         _audioTitle = '';
//   //         _audioDuration = const Duration();
//   //       });
//   //     }
//   //   });
//   // }

//   @override
//   void dispose() {
//    // _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xD5F4D3D4),
//         automaticallyImplyLeading: false,
//         title: const Align(
//           alignment: AlignmentDirectional(-1.00, 0.00),
//           child: Text(
//             'TuneMix',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//               fontFamily: 'Belgrano',
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               shadows: [
//                 Shadow(
//                   offset: Offset(0, 4.0),
//                   blurRadius: 4.0,
//                   color: Color.fromARGB(59, 0, 0, 0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         elevation: 10,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 2),
//             child: Image.asset(
//               'images/logo.png',
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           ListView(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       Positioned(
//                         top: MediaQuery.of(context).size.height / 2 - 100,
//                         left: MediaQuery.of(context).size.width / 2 - 150,
//                         child: Opacity(
//                           opacity: 0.5,
//                           child: Image.asset(
//                             'images/logo.png',
//                             width: 300,
//                             height: 200,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height,
//                         decoration: const BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color(0xFFFFE7E7),
//                               Color(0xD5F4D3D4),
//                               Color(0x3D6C5278),
//                               Color(0x9DD6EDB2),
//                               Color(0xB97DAEA5)
//                             ],
//                             stops: [0, 0.2, 0.5, 0.8, 1],
//                             begin: AlignmentDirectional(0, -1),
//                             end: AlignmentDirectional(0, 1),
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: ElevatedButton(
//                                 onPressed: _navigateToSearchScreen,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.white,
//                                   foregroundColor: Colors.black,
//                                   textStyle: const TextStyle(
//                                     fontFamily: 'Itim',
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   side: const BorderSide(
//                                     color: Color.fromARGB(184, 224, 224, 224),
//                                     width: 3,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   minimumSize: const Size(double.infinity, 45),
//                                 ),
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Icon(
//                                       Icons.search_rounded,
//                                       color: Color.fromARGB(255, 154, 154, 154),
//                                       size: 20,
//                                     ),
//                                     SizedBox(width: 10),
//                                     Text('Search...'),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const Padding(
//                               padding:
//                                   EdgeInsets.only(top: 18, left: 18, right: 18),
//                               child: Text(
//                                 'Artist',
//                                 style: TextStyle(
//                                   fontFamily: 'Kavoon',
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //       top: 10, left: 18, right: 18),
//                             //   child: SingleChildScrollView(
//                             //     scrollDirection: Axis.horizontal,
//                             //     child: Row(
//                             //       mainAxisSize: MainAxisSize.max,
//                             //       children: artists.map((artist) {
//                             //         return Padding(
//                             //           padding:
//                             //               const EdgeInsetsDirectional.fromSTEB(
//                             //                   0, 0, 12, 0),
//                             //           child: GestureDetector(
//                             //             onTap: () {
//                             //               _navigateToArtistScreen(artist.name,
//                             //                   artist.image, artist.songs);
//                             //             },
//                             //             child: Column(
//                             //               mainAxisAlignment:
//                             //                   MainAxisAlignment.start,
//                             //               children: [
//                             //                 ClipRRect(
//                             //                   borderRadius:
//                             //                       BorderRadius.circular(8),
//                             //                   child: Image.asset(
//                             //                     artist.image,
//                             //                     width: 120,
//                             //                     height: 120,
//                             //                     fit: BoxFit.contain,
//                             //                   ),
//                             //                 ),
//                             //                 Text(
//                             //                   artist.name,
//                             //                   style: const TextStyle(
//                             //                     fontFamily: 'Kite One',
//                             //                   ),
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //         );
//                             //       }).toList(),
//                             //     ),
//                             //   ),
//                             // ),
//                             const Padding(
//                               padding:
//                                   EdgeInsets.only(top: 18, left: 18, right: 18),
//                               child: Text(
//                                 'Genre',
//                                 style: TextStyle(
//                                   fontFamily: 'Kavoon',
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //       top: 10, left: 18, right: 18),
//                             //   child: SingleChildScrollView(
//                             //     scrollDirection: Axis.horizontal,
//                             //     child: Row(
//                             //       mainAxisSize: MainAxisSize.max,
//                             //       children: genres.map((genre) {
//                             //         return Padding(
//                             //           padding:
//                             //               const EdgeInsetsDirectional.fromSTEB(
//                             //                   0, 0, 12, 0),
//                             //           child: GestureDetector(
//                             //             onTap: () {
//                             //               _navigateToGenreScreen(
//                             //                 genre.name,
//                             //                 genre.image,
//                             //                 genre.songs,
//                             //                 genre.name1,
//                             //                 genre.image1,
//                             //                 genre.songs1,
//                             //                 genre.name2,
//                             //                 genre.image2,
//                             //                 genre.songs2,
//                             //               );
//                             //             },
//                             //             child: Column(
//                             //               mainAxisSize: MainAxisSize.max,
//                             //               children: [
//                             //                 ClipRRect(
//                             //                   borderRadius:
//                             //                       BorderRadius.circular(8),
//                             //                   child: Image.asset(
//                             //                     genre.image,
//                             //                     width: 120,
//                             //                     height: 120,
//                             //                     fit: BoxFit.cover,
//                             //                   ),
//                             //                 ),
//                             //                 Text(
//                             //                   genre.name,
//                             //                   style: const TextStyle(
//                             //                     fontFamily: 'Kite One',
//                             //                   ),
//                             //                 ),
//                             //               ],
//                             //             ),
//                             //           ),
//                             //         );
//                             //       }).toList(),
//                             //     ),
//                             //   ),
//                             // ),
//                             const Padding(
//                               padding:
//                                   EdgeInsets.only(top: 18, left: 18, right: 18),
//                               child: Text(
//                                 'Mix Made for You',
//                                 style: TextStyle(
//                                   fontFamily: 'Kavoon',
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 10, left: 18, right: 18),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 // child: Row(
//                                 //   mainAxisSize: MainAxisSize.max,
//                                 //   children: mixPlaylists.map((mixPlaylist) {
//                                 //     return Padding(
//                                 //       padding:
//                                 //           const EdgeInsetsDirectional.fromSTEB(
//                                 //               0, 0, 12, 0),
//                                 //       child: GestureDetector(
//                                 //         onTap: () {
//                                 //           _navigateToMixScreen(
//                                 //               mixPlaylist.name,
//                                 //               mixPlaylist.image,
//                                 //               mixPlaylist.songs);
//                                 //         },
//                                 //         child: Column(
//                                 //           mainAxisSize: MainAxisSize.max,
//                                 //           children: [
//                                 //             ClipRRect(
//                                 //               borderRadius:
//                                 //                   BorderRadius.circular(8),
//                                 //               child: Image.asset(
//                                 //                 mixPlaylist.image,
//                                 //                 width: 120,
//                                 //                 height: 120,
//                                 //                 fit: BoxFit.cover,
//                                 //               ),
//                                 //             ),
//                                 //             Text(
//                                 //               mixPlaylist.name,
//                                 //               style: const TextStyle(
//                                 //                 fontFamily: 'Kite One',
//                                 //               ),
//                                 //             ),
//                                 //           ],
//                                 //         ),
//                                 //       ),
//                                 //     );
//                                 //   }).toList(),
//                                 // ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF747474),
//                       Color(0xFFC1C1C1),
//                     ],
//                     stops: [0, 0.4],
//                     begin: AlignmentDirectional(0, -1),
//                     end: AlignmentDirectional(0, 1),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                             'https://tse1.mm.bing.net/th?id=OIP.lZd-WMzVF3qYYbTlBCzPSwHaHa&pid=Api&P=0&h=180',
//                             width: 40,
//                             height: 40),
//                       ),
//                     ),

//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _audioTitle,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                             fontFamily: 'Lilita One',
//                           ),
//                         ),
//                         Text(
//                           '${_audioDuration.inMinutes}:${(_audioDuration.inSeconds % 60).toString().padLeft(2, '0')}',
//                           style: const TextStyle(
//                             fontFamily: 'Itim',
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       icon: const Icon(Icons.play_arrow),
//                       onPressed: () {
//                        // playAudio('assets/audios/Bruno-Mars-Versace-On-The-Floor.mp3');
//                       },
//                     ),
//                     // Pause Button
//                     IconButton(
//                       icon: const Icon(Icons.pause),
//                       onPressed: () {
//                         //pauseAudio();
//                       },
//                     ),
//                     // Stop Button
//                     IconButton(
//                       icon: const Icon(Icons.stop),
//                       onPressed: () {
//                        // stopAudio();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(
//           canvasColor: const Color.fromARGB(255, 214, 240, 238),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//               _navigateToPage(index);
//             });
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//                 color: _currentIndex == 0
//                     ? Colors.deepPurple
//                     : const Color.fromARGB(255, 48, 162, 159),
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.search,
//                 color: _currentIndex == 1
//                     ? Colors.deepPurple
//                     : const Color.fromARGB(255, 48, 162, 159),
//               ),
//               label: 'Search',
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 _currentIndex == 2
//                     ? 'images/story.png'
//                     : 'images/story.png',
//                   width: 24,
//                   height: 24,
//                   color: _currentIndex == 2
//                       ? Colors.deepPurple
//                       : const Color.fromARGB(255, 48, 162, 159),
//               ),
//               label: 'Story',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.favorite,
//                 color: _currentIndex == 3
//                     ? Colors.deepPurple
//                     : const Color.fromARGB(255, 48, 162, 159),
//               ),
//               label: 'Favorite',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.account_circle_rounded,
//                 color: _currentIndex == 4
//                     ? Colors.deepPurple
//                     : const Color.fromARGB(255, 48, 162, 159),
//               ),
//               label: 'Account',
//             ),
//           ],
//           showUnselectedLabels: false,
//           showSelectedLabels: false,
//         ),
//       ),
//     );
//   }

//   void _navigateToSearchScreen() {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) {
//           return const SearchScreen();
//         },
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = 0.0;
//           const end = 1.0;
//           var tween = Tween(begin: begin, end: end);

//           var fadeInAnimation = animation.drive(tween);

//           return FadeTransition(
//             opacity: fadeInAnimation,
//             child: child,
//           );
//         },
//         transitionDuration: const Duration(milliseconds: 800),
//       ),
//     );
//   }

//   // void _navigateToArtistScreen(
//   //     String artistName, String artistImage, List<Song> songs) {
//   //   Navigator.push(
//   //     context,
//   //     PageRouteBuilder(
//   //       pageBuilder: (context, animation, secondaryAnimation) {
//   //         return AlbumScreen(
//   //           artistName: artistName,
//   //           albumImage: artistImage,
//   //           songs: songs,
//   //         );
//   //       },
//   //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //         const begin = 0.0;
//   //         const end = 1.0;
//   //         var tween = Tween(begin: begin, end: end);

//   //         var rotationAnimation = Tween(begin: 0.0, end: 360.0).animate(
//   //           CurvedAnimation(
//   //             parent: animation,
//   //             curve: Curves.easeInOut,
//   //           ),
//   //         );

//   //         var fadeOutAnimation = animation.drive(tween);

//   //         return RotationTransition(
//   //           turns: rotationAnimation,
//   //           child: FadeTransition(
//   //             opacity: fadeOutAnimation,
//   //             child: child,
//   //           ),
//   //         );
//   //       },
//   //       transitionDuration: const Duration(milliseconds: 500),
//   //     ),
//   //   );
//   // }

//   // void _navigateToGenreScreen(
//   //     String genreName,
//   //     String genreImage,
//   //     List<Song> songs,
//   //     String genreName1,
//   //     String genreImage1,
//   //     List<Song> songs1,
//   //     String genreName2,
//   //     String genreImage2,
//   //     List<Song> songs2) {
//   //   Navigator.push(
//   //     context,
//   //     PageRouteBuilder(
//   //       pageBuilder: (context, animation, secondaryAnimation) {
//   //         return GenreScreen(
//   //           genreName: genreName,
//   //           genreImage: genreImage,
//   //           songs: songs,
//   //           genreName1: genreName1,
//   //           genreImage1: genreImage1,
//   //           songs1: songs1,
//   //           genreName2: genreName2,
//   //           genreImage2: genreImage2,
//   //           songs2: songs2,
//   //         );
//   //       },
//   //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //         const begin = 0.0;
//   //         const end = 1.0;
//   //         var tween = Tween(begin: begin, end: end);

//   //         var rotationAnimation = Tween(begin: 0.0, end: 360.0).animate(
//   //           CurvedAnimation(
//   //             parent: animation,
//   //             curve: Curves.easeInOut,
//   //           ),
//   //         );

//   //         var fadeOutAnimation = animation.drive(tween);

//   //         return RotationTransition(
//   //           turns: rotationAnimation,
//   //           child: FadeTransition(
//   //             opacity: fadeOutAnimation,
//   //             child: child,
//   //           ),
//   //         );
//   //       },
//   //       transitionDuration: const Duration(milliseconds: 500),
//   //     ),
//   //   );
//   // }

//   // void _navigateToMixScreen(String mixName, String mixImage, List<Song> songs) {
//   //   Navigator.push(
//   //     context,
//   //     PageRouteBuilder(
//   //       pageBuilder: (context, animation, secondaryAnimation) {
//   //         return AlbumScreen(
//   //           artistName: mixName,
//   //           albumImage: mixImage,
//   //           songs: songs,
//   //         );
//   //       },
//   //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //         const begin = 0.0;
//   //         const end = 1.0;
//   //         var tween = Tween(begin: begin, end: end);

//   //         var rotationAnimation = Tween(begin: 0.0, end: 360.0).animate(
//   //           CurvedAnimation(
//   //             parent: animation,
//   //             curve: Curves.easeInOut,
//   //           ),
//   //         );

//   //         var fadeOutAnimation = animation.drive(tween);

//   //         return RotationTransition(
//   //           turns: rotationAnimation,
//   //           child: FadeTransition(
//   //             opacity: fadeOutAnimation,
//   //             child: child,
//   //           ),
//   //         );
//   //       },
//   //       transitionDuration: const Duration(milliseconds: 500),
//   //     ),
//   //   );
//   // }

//   void _navigateToPage(int index) {
//     var routeBuilder;
//     switch (index) {
//       case 0:
//         routeBuilder = '/home';
//         break;
//       case 1:
//         routeBuilder = '/search';
//         break;
//       case 2:
//         routeBuilder = '/story';
//         break;
//       case 3:
//         routeBuilder = '/fav';
//         break;
//       case 4:
//         routeBuilder = '/account';
//         break;
//     }

//     if (index == 2) {
//       Navigator.push(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 const StoryScreen(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               const begin = 0.0;
//               const end = 1.0;
//               var tween = Tween(begin: begin, end: end);

//               var fadeOutAnimation = animation.drive(tween);

//               return FadeTransition(
//                 opacity: fadeOutAnimation,
//                 child: child,
//               );
//             },
//             transitionDuration: const Duration(milliseconds: 500),
//           ));
//     }

//     Navigator.pushReplacement(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) {
//           switch (index) {
//             case 0:
//               return const HomeScreen();
//             case 1:
//               return const SearchScreen();
//             case 2:
//               return const StoryScreen();
//             case 3:
//               return const FavoriteScreen(
//                // favoriteSongs: [],
//                // favoritePodcasts: [],
//               );
//             case 4:
//               return const UserProfile(imageUrl: '',);
//             default:
//               return Container();
//           }
//         },
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = 0.0;
//           const end = 1.0;
//           var tween = Tween(begin: begin, end: end);

//           var fadeOutAnimation = animation.drive(tween);

//           return FadeTransition(
//             opacity: fadeOutAnimation,
//             child: child,
//           );
//         },
//         transitionDuration: const Duration(milliseconds: 800),
//       ),
//     );
//   }

//   // Future<void> playAudio(String filePath) async {
//   //   await _audioPlayer.play(filePath, isLocal: true);

//   //   _audioPlayer.onAudioPositionChanged.listen((Duration position) {
//   //     setState(() {
//   //       _audioDuration = position;
//   //     });
//   //   });
//   //   _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//   //     if (state == PlayerState.PLAYING) {
//   //       setState(() {
//   //         _audioTitle = 'Bruno Mars - Versace on the Floor';
//   //       });
//   //     } else if (state == PlayerState.PAUSED) {
//   //     } else if (state == PlayerState.STOPPED) {
//   //       setState(() {
//   //         _audioTitle = '';
//   //         _audioDuration = const Duration();
//   //       });
//   //     }
//   //   });
//   // }

//   // Future<void> pauseAudio() async {
//   //   await _audioPlayer.pause();
//   // }

//   // Future<void> stopAudio() async {
//   //   await _audioPlayer.stop();
//   //   setState(() {
//   //     _audioTitle = '';
//   //     _audioDuration = const Duration();
//   //   });
//   // }
// }
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiKey = 'AIzaSyCj4WscNwHbvq3OmDgb89uFPQTFi7R8XPA';
  final youtubeAPI = YouTubeAPI(apiKey, maxResults: 10);
  late List<YT_API> _videos;

  @override
  void initState() {
    super.initState();
    _fetchYouTubeVideos();
  }

  Future<void> _fetchYouTubeVideos() async {
    try {
      YoutubeSearchResponse result = await youtubeAPI.search('Music');
      setState(() {
        _videos = result.results;
      });
    } catch (e) {
      print('Error fetching YouTube videos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_videos[index].title),
            subtitle: Image.network(_videos[index].thumbnail['default']['url']),
            onTap: () {
              // Tambahkan logika untuk menangani ketika video dipilih
            },
          );
        },
      ),
    );
  }
}
