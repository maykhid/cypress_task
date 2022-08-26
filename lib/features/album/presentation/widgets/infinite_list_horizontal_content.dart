import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/utils/extensions.dart';
import '../../blocs/bloc/photos_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteListHorizontalContent extends StatelessWidget {
  const InfiniteListHorizontalContent({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosBlocState>(
      builder: (context, state) {
        if (state.status == PhotosStatus.success) {
          return CachedNetworkImage(
            height: context.height,
            width: context.width * 0.4,
            fit: BoxFit.cover,
            imageUrl: state.photos[index].thumbnailUrl.toString(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Image.asset('assets/images/150x150.png'),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/150x150.png'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
