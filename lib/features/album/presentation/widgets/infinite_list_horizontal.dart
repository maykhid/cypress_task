import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/utils/extensions.dart';
import '../../blocs/photos_bloc/photos_bloc_bloc.dart';
import 'infinite_list_horizontal_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteListHorizontal extends StatefulWidget {
  const InfiniteListHorizontal({
    Key? key,
  }) : super(key: key);

  @override
  State<InfiniteListHorizontal> createState() => _InfiniteListHorizontalState();
}

class _InfiniteListHorizontalState extends State<InfiniteListHorizontal> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosBlocState>(
      builder: (context, state) {
        if (state.status == PhotosStatus.success) {
          return CarouselSlider.builder(
            itemCount: state.photos.length,
            itemBuilder: (context, index, realIndex) =>
                InfiniteListHorizontalContent(index: index),
            options: CarouselOptions(
              padEnds: false,
              height: context.height * 0.2,
              viewportFraction: 0.45,
              pageSnapping: false,
            ),
          );
        }

        return  Center(child: const CircularProgressIndicator().paddingOnly(top: context.height * 0.065));
      },
    );
  }
}
