import 'package:flutter/material.dart';
import 'package:tunemix_apps/screens/story_edit_screen.dart';
import 'package:tunemix_apps/services/story_service.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryListScreen extends StatefulWidget {
  const StoryListScreen({super.key});

  @override
  State<StoryListScreen> createState() => _StoryListScreenState();
}

class _StoryListScreenState extends State<StoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Story'),
      ),
      body: const StoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StoryEditScreen(),
            ),
          ); //push bs balek lagi, pushReplacement dbs balek
         
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}


class StoryList extends StatelessWidget {
  const StoryList({super.key});

  Future<void> _launchMaps(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    try {
      await launchUrl(googleUrl);
    } catch (e) {
      print('Could not open the map: $e');
      // Optionally, show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: StoryService.getStoryList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: snapshot.data!.map((document) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryEditScreen(story: document),
                        ),
                      );
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return NoteDialog(note: document);
                      //   },
                      // );
                    },
                    child: Column(
                      children: [
                        document.imageUrl != null &&
                                Uri.parse(document.imageUrl!).isAbsolute
                            ? ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  document.imageUrl!,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 150,
                                ),
                              )
                            : Container(),
                        ListTile(
                          title: Text(document.title),
                          subtitle: Text(document.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.map),
                                onPressed: document.latitude != null &&
                                        document.longitude != null
                                    ? () {
                                        _launchMaps(document.latitude!,
                                            document.longitude!);
                                      }
                                    : null, // Disable the button if latitude or longitude is null
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Konfirmasi Hapus'),
                                        content: Text(
                                            'Yakin ingin menghapus data \'${document.title}\' ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Hapus'),
                                            onPressed: () {
                                              StoryService.deleteStroy(document)
                                                  .whenComplete(() =>
                                                      Navigator.of(context)
                                                          .pop());
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}


// class _StoryListScreenState extends State<StoryListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFE7E7),
//               Color(0xD5F4D3D4),
//               Color(0x3D6C5278),
//               Color(0x9DD6EDB2),
//               Color(0xB97DAEA5)
//             ],
//             stops: [0, 0.2, 0.5, 0.8, 1],
//             begin: AlignmentDirectional(0, -1),
//             end: AlignmentDirectional(0, 1),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       'images/arrowback.png',
//                       width: 30,
//                       height: 30,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   const Icon(
//                     Icons.more_vert,
//                     color: Colors.black,
//                     size: 30,
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: 80,
//                         height: 80,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.asset(
//                           'images/arrowback.png',
//                           fit: BoxFit.contain,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 272,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 2,
//                               color: Color(0x33000000),
//                               offset: Offset(
//                                 4,
//                                 4,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 60,
//                                       height: 60,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Image.asset(
//                                         'images/arrowback.png',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           10, 0, 0, 0),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Taylor',
//                                             style: TextStyle(
//                                                 fontFamily: 'Inknut Antiqua',
//                                                 fontSize: 17),
//                                           ),
//                                           Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Icon(
//                                                 Icons.location_pin,
//                                                 color: Colors.black,
//                                                 size: 24,
//                                               ),
//                                               Text(
//                                                 'Universitas Multi Data Palembang',
//                                                 style: TextStyle(
//                                                     fontFamily: 'Itim',
//                                                     fontSize: 12),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     const Expanded(
//                                       child: Align(
//                                         alignment: AlignmentDirectional(1, 0),
//                                         child: Icon(
//                                           Icons.keyboard_control_sharp,
//                                           color: Colors.black,
//                                           size: 24,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       0, 10, 0, 0),
//                                   child: Container(
//                                     width: double.infinity,
//                                     height: 70,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF8E00FF),
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Container(
//                                             width: 60,
//                                             height: 60,
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: const BoxDecoration(
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Image.asset(
//                                               'images/arrowback.png',
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                           const Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Perfect',
//                                                 style: TextStyle(
//                                                     fontFamily:
//                                                         'Inknut Antiqua',
//                                                     fontSize: 12,
//                                                     color: Colors.white),
//                                               ),
//                                               Text(
//                                                 'Ed Sheeran',
//                                                 style: TextStyle(
//                                                     fontFamily:
//                                                         'Inknut Antiqua',
//                                                     fontSize: 12,
//                                                     color: Colors.white),
//                                               ),
//                                             ],
//                                           ),
//                                           const Expanded(
//                                             child: Align(
//                                               alignment:
//                                                   AlignmentDirectional(1, 0),
//                                               child: Icon(
//                                                 Icons.play_arrow,
//                                                 color: Colors.white,
//                                                 size: 35,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const Align(
//                                 alignment: AlignmentDirectional(-1, 0),
//                                 child: Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       10, 10, 0, 0),
//                                   child: Text(
//                                     'WOWWW',
//                                     style: TextStyle(
//                                         fontFamily: 'Belgrano',
//                                         fontSize: 12,
//                                         color: Colors.black),
//                                   ),
//                                 ),
//                               ),
//                               const Expanded(
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0, 1),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'April, 1st 2024',
//                                         style: TextStyle(
//                                             fontFamily: 'Itim',
//                                             fontSize: 10,
//                                             color: Colors.black),
//                                       ),
//                                       Text(
//                                         '17927',
//                                         style: TextStyle(
//                                             fontFamily: 'Itim',
//                                             fontSize: 10,
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const Divider(
//                                 thickness: 1,
//                                 color: Color(0xF8000000),
//                               ),
//                               Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Icon(
//                                         Icons.favorite_rounded,
//                                         color: Colors.black,
//                                         size: 24,
//                                       ),
//                                       Text(
//                                         '1',
//                                         style: TextStyle(
//                                             fontFamily: 'Itim',
//                                             fontSize: 15,
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       _showCommentPopup(context);
//                                     },
//                                     child: const Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Icon(
//                                           Icons.comment,
//                                           color: Colors.black,
//                                           size: 24,
//                                         ),
//                                         Text(
//                                           '1',
//                                           style: TextStyle(
//                                               fontFamily: 'Itim',
//                                               fontSize: 15,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.share_sharp,
//                                     color: Colors.black,
//                                     size: 24,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCommentPopup(BuildContext context) {
//     // Fungsi untuk menampilkan popup komentar
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const SizedBox(
//                 width: 60,
//                 child: Divider(
//                   thickness: 5,
//                   color: Colors.black,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: Image.asset(
//                             'images/arrowback.png',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Hello World',
//                                 style: TextStyle(
//                                     fontFamily: 'Itim',
//                                     fontSize: 15,
//                                     color: Colors.black),
//                               ),
//                               Text(
//                                 'Hello World',
//                                 style: TextStyle(
//                                     fontFamily: 'Itim',
//                                     fontSize: 12,
//                                     color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Expanded(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '1 minutes ago',
//                                 style: TextStyle(
//                                     fontFamily: 'Itim',
//                                     fontSize: 8,
//                                     color: Colors.black),
//                               ),
//                               Icon(
//                                 Icons.favorite_sharp,
//                                 color: Colors.red,
//                                 size: 20,
//                               ),
//                               Icon(
//                                 Icons.comment_rounded,
//                                 color: Colors.cyanAccent,
//                                 size: 20,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Divider(
//                       thickness: 1,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: const AlignmentDirectional(0, 1),
//                 child: Container(
//                   width: double.infinity,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                   ),
//                   child: Padding(
//                     padding:
//                         const EdgeInsetsDirectional.fromSTEB(10, 15, 10, 15),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: Image.asset(
//                             'images/arrowback.png',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Container(
//                           width: 280,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Align(
//                             alignment: const AlignmentDirectional(0, 0),
//                             child: Text(
//                               'Hello World',
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: const AlignmentDirectional(1, 0),
//                             child: Icon(
//                               Icons.send_rounded,
//                               color: Colors.white,
//                               size: 30,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
