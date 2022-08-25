import 'package:cypress_task/core/utils/extensions.dart';
import 'package:cypress_task/features/album/cubit/album_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocProvider(
        create: (context) => AlbumCubit()..getAlbums(),
        child: BlocConsumer<AlbumCubit, AlbumState>(
          listener: (context, state) {
            if (state is AlbumLoading) {
              print('loading...');
            } else if (state is AlbumLoaded) {
              print(state.response![0].title);
            } else if (state is AlbumFailure) {
              print('failed');
            }
          },
          builder: (context, state) {
            return SizedBox(
                height: context.height,
                width: context.width,
                child: state is AlbumLoaded
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (scrollEnd) {
                          final metrics = scrollEnd.metrics;
                          if (metrics.atEdge) {
                            bool isTop = metrics.pixels == 0;
                            if (isTop) {
                              print('At the top');
                            } else {
                              // append list here
                              print('At the bottom');
                            }
                          }
                          return true;
                        },
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              const InfintieListContent(),
                          itemCount: state.response!.length,
                          separatorBuilder: (context, index) => Container(
                            color: Colors.black,
                            height: context.height * 0.001,
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
                // child: ,
                );
          },
        ),
      ),
    );
  }
}

class InfintieListContent extends StatelessWidget {
  const InfintieListContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Album Title'),
          NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              final metrics = scrollEnd.metrics;
              if (metrics.atEdge) {
                bool isTop = metrics.pixels == 0;
                if (isTop) {
                  // print('At the top');
                } else {
                  // append list here
                  print('At the horozonatal end');
                }
              }
              return true;
            },
            child: SizedBox(
              height: context.height * 0.2,
              width: context.width,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const HorizontalListContent(),
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(
                  // color: Colors.black,
                  width: context.height * 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalListContent extends StatelessWidget {
  const HorizontalListContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width * 0.4,
      color: Colors.red,
    );
  }
}
