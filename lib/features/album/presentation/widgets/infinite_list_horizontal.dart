import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../dependency_injector.dart';
import '../../blocs/photos_bloc/photos_bloc_bloc.dart';
import 'infinite_list_horizontal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteListHorizontal extends StatefulWidget {
  const InfiniteListHorizontal({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<InfiniteListHorizontal> createState() => _InfiniteListHorizontalState();
}

class _InfiniteListHorizontalState extends State<InfiniteListHorizontal> {
  late PhotosBloc bloc;

  @override
  void initState() {
    int id = widget.id;

    // BlocProvider.of<PhotosBloc>(context)
    //     .add(PhotosFetched(id.toString()));
    bloc = PhotosBloc(photoRepo: di(), photoLocalDataSrc: di())..add(PhotosFetched(id.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosBlocState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == PhotosStatus.success) {
          print(state.photos);
          return CarouselSlider.builder(
            itemCount: state.photos.length,
            itemBuilder: (context, index, realIndex) =>
                InfiniteListHorizontalContent(index: index, photos: state.photos,),
            options: CarouselOptions(
              padEnds: false,
              height: context.height * 0.2,
              viewportFraction: 0.45,
              pageSnapping: false,
            ),
          );
        }

        return Center(
            child: const CircularProgressIndicator()
                .paddingOnly(top: context.height * 0.065));
      },
    );
  }
}
