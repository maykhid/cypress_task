import 'package:cypress_task/core/utils/extensions.dart';
import 'package:cypress_task/features/album/presentation/widgets/infinite_list_vertical_content.dart';
import 'package:flutter/material.dart';

class InfiniteListVertical extends StatelessWidget {
  const InfiniteListVertical({
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
            print('At the top');
          } else {
            // append list here
            print('At the bottom');
          }
        }
        return true;
      },
      child: ListView.separated(
        itemBuilder: (context, index) =>  InfiniteListVerticalContent(),
        itemCount: 10,
        separatorBuilder: (context, index) => Container(
          color: Colors.black,
          height: context.height * 0.001,
        ),
      ),
    );
  }
}
