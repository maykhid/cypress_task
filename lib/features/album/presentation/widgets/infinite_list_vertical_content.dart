import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/spacing.dart';
// import 'package:cypress_task/features/album/cubit/album_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/albums_bloc/album_bloc.dart';
import 'infinite_list_horizontal.dart';

class InfiniteListVerticalContent extends StatefulWidget {
  const InfiniteListVerticalContent({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<InfiniteListVerticalContent> createState() =>
      _InfiniteListVerticalContentState();
}

class _InfiniteListVerticalContentState
    extends State<InfiniteListVerticalContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state.status == AlbumStatus.success) {
          return SizedBox(
            height: context.height * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(),
                Text(
                  ' ${state.albums[widget.index].title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.height * 0.025,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const InfiniteListHorizontal(),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
