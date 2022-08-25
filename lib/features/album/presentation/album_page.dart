import 'package:cypress_task/core/utils/extensions.dart';
import 'package:cypress_task/features/album/cubit/album_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/infinite_list_vertical.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album App'),
      ),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          return SizedBox(
            height: context.height,
            width: context.width,
            child: state is AlbumLoaded
                ? const InfiniteListVertical()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            // child: ,
          );
        },
      ),
    );
  }
}
