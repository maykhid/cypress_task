import 'package:cypress_task/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Album App'),
      ),
      body: SizedBox(
        height: context.height,
        width: context.width,
        // child: ,
      ),
    );
  }
}
