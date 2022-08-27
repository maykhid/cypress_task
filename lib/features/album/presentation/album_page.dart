import '../../../core/utils/extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/albums_bloc/album_bloc.dart';
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
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          switch (state.status) {
            case AlbumStatus.initial:
              return SizedBox(
                height: context.height,
                width: context.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
                // child: ,
              );
            case AlbumStatus.success:
              return SizedBox(
                  height: context.height,
                  width: context.width,
                  child: const InfiniteListVertical());
            case AlbumStatus.failure:
              return SizedBox(
                height: context.height,
                width: context.width,
                child: const Center(
                    child: Text('Please check internet connection!')),
              );
          }
        },
      ),
    );
  }
}
