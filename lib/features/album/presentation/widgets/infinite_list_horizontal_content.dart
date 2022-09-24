import 'package:cached_network_image/cached_network_image.dart';
import 'package:cypress_task/features/album/data/model/response/photo_response.dart';
import '../../../../core/utils/extensions.dart';
import 'package:flutter/material.dart';

class InfiniteListHorizontalContent extends StatelessWidget {
  const InfiniteListHorizontalContent({
    Key? key,
    required this.index,
    required this.photos,
  }) : super(key: key);
  final int index;
  final List<PhotoResponse> photos;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: context.height,
      width: context.width * 0.4,
      fit: BoxFit.cover,
      // httpHeaders: const {"Accept": "*/*", "User-Agent": "Mozilla/5.0 (Linux; Android 10; SM-G996U Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Mobile Safari/537.36"},
      imageUrl: photos[index].url.toString(),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Image.asset('assets/images/150x150.png'),
      errorWidget: (context, url, error) =>
          Image.asset('assets/images/150x150.png'),
    );
  }
}
