import 'package:bloc/bloc.dart';
import '../../data/model/response/album_response.dart';
import 'package:equatable/equatable.dart';

import '../../data/data_sources/local/album_local.dart';
import '../../data/repositories/album_repo.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc({AlbumRepo? albumRepo, AlbumLocalDataSrc? albumLocalDataSrc})
      : super(AlbumState()) {
    on<AlbumFetched>((event, emit) async {
      if (state.hasReachedMax ?? false) return;

      if (state.status == AlbumStatus.initial) {
        final albums = await albumRepo!.getAlbums();
        return emit(albums!.fold(
            (l) => state.copyWith(status: AlbumStatus.failure),
            (r) => state.copyWith(
                status: AlbumStatus.success, albums: r, hasReachedMax: false)));
      }

      try {
        final cachedAlbums = await albumLocalDataSrc!.getCachedAlbums();
        if (cachedAlbums != null) {
          emit(state.copyWith(
            status: AlbumStatus.success,
            albums: List.of(state.albums)..addAll(cachedAlbums),
            hasReachedMax: false,
          ));
        }
      } catch (_) {
        emit(state.copyWith(status: AlbumStatus.failure));
      }
    });
  }
}
