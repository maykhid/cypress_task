import 'package:cypress_task/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/photo_cubit.dart';
import 'infinite_list_horizontal.dart';

class InfiniteListVerticalContent extends StatefulWidget {
  const InfiniteListVerticalContent({
    Key? key,
  }) : super(key: key);

  @override
  State<InfiniteListVerticalContent> createState() => _InfiniteListVerticalContentState();
}

class _InfiniteListVerticalContentState extends State<InfiniteListVerticalContent> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PhotoCubit>().state;

    return SizedBox(
      height: context.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Album Title'),
          InfiniteListHorizontal(),
        ],
      ),
    );
  }
}