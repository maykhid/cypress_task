import '../../../../core/utils/extensions.dart';
import 'infinite_list_vertical_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/albums_bloc/album_bloc.dart';

class InfiniteListVertical extends StatefulWidget {
  const InfiniteListVertical({
    Key? key,
  }) : super(key: key);

  @override
  State<InfiniteListVertical> createState() => _InfiniteListVerticalState();
}

class _InfiniteListVerticalState extends State<InfiniteListVertical> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<AlbumBloc, AlbumState>(
     
      builder: (context, state) {
        if (state.status == AlbumStatus.success) {
          return ListView.separated(
            itemBuilder: (context, index) => index >= state.albums.length ? Container() : 
                InfiniteListVerticalContent(index: index),
            itemCount: state.hasReachedMax ?? false ? state.albums.length : state.albums.length + 1,
            controller: _scrollController,
            separatorBuilder: (context, index) => Container(
              color: Colors.black,
              height: context.height * 0.001,
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
    // );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<AlbumBloc>().add(AlbumFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
