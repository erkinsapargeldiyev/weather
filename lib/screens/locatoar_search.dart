// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocatoarSearch extends StatefulWidget {
  bool searchIndicator;
  String title;
  LocatoarSearch({
    super.key,
    required this.searchIndicator,
    required this.title,
  });

  @override
  State<LocatoarSearch> createState() => _LocatoarSearchState();
}

class _LocatoarSearchState extends State<LocatoarSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(1, -1.2),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(color: Color(0xffFFAB40)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(color: Colors.transparent),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                if (widget.searchIndicator) ...[
                  CircularProgressIndicator(color: Colors.white),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
