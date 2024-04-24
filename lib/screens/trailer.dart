import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTrailer extends StatelessWidget {
  const MovieTrailer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CupertinoNavigationBar(),
      body: Center(child: Text('Movie Trailer')),
    );
  }
}
