import 'package:cypress_task/core/utils/extensions.dart';
import 'package:cypress_task/features/album/presentation/widgets/infinite_list_horizontal_content.dart';
import 'package:flutter/material.dart';

import '../../data/model/response/photo_response.dart';

class InfiniteListHorizontal extends StatelessWidget {
  const InfiniteListHorizontal({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isTop = metrics.pixels == 0;
          if (isTop) {
            // print('At the top');
          } else {
            // append list here
            print('At the horozontal end');
          }
        }
        return true;
      },
      child: SizedBox(
        height: context.height * 0.2,
        width: context.width,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const InfiniteListHorizontalContent(),
          itemCount: 10,
          separatorBuilder: (context, index) => SizedBox(
            // color: Colors.black,
            width: context.height * 0.02,
          ),
        ),
      ),
    );
  }
}
