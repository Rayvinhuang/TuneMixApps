import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'images/arrowback.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'images/arrowback.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 272,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              color: Color(0x33000000),
                              offset: Offset(
                                4,
                                4,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'images/arrowback.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Taylor',
                                            style: TextStyle(
                                                fontFamily: 'Inknut Antiqua',
                                                fontSize: 17),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.location_pin,
                                                color: Colors.black,
                                                size: 24,
                                              ),
                                              Text(
                                                'Universitas Multi Data Palembang',
                                                style: TextStyle(
                                                    fontFamily: 'Itim',
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Icon(
                                          Icons.keyboard_control_sharp,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF8E00FF),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(
                                              'images/arrowback.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Perfect',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Inknut Antiqua',
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'Ed Sheeran',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Inknut Antiqua',
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(1, 0),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 0),
                                  child: Text(
                                    'WOWWW',
                                    style: TextStyle(
                                        fontFamily: 'Belgrano',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'April, 1st 2024',
                                        style: TextStyle(
                                            fontFamily: 'Itim',
                                            fontSize: 10,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '17927',
                                        style: TextStyle(
                                            fontFamily: 'Itim',
                                            fontSize: 10,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Color(0xF8000000),
                              ),
                              const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      Text(
                                        '1',
                                        style: TextStyle(
                                            fontFamily: 'Itim',
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      Text(
                                        '1',
                                        style: TextStyle(
                                            fontFamily: 'Itim',
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.share_sharp,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
