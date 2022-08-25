import 'package:cypress_task/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class InfiniteListHorizontalContent extends StatelessWidget {
  const InfiniteListHorizontalContent({
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