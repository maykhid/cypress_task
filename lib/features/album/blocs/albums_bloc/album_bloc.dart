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

      /// On [AlbumStatus.initial] Gets data from either server or cache (depending on if internet connection exists) 
      /// 

      if (state.status == AlbumStatus.initial) {
        final albums = await albumRepo!.getAlbums();
        return emit(albums!.fold(
            (l) => state.copyWith(status: AlbumStatus.failure),
            (r) => state.copyWith(
                status: AlbumStatus.success, albums: r, hasReachedMax: false)));
      }

      /// On subsequnent calls, since the data is always the same instead of loading data from the internet
      /// get from cache instead and append to previous album data.

      try {
        final cachedAlbums = await albumLocalDataSrc!.getCachedAlbums();
        if (cachedAlbums != null) {
          emit(state.copyWith(
            status: AlbumStatus.success,
            albums: List.of(state.albums)..addAll(cachedAlbums),
            hasReachedMax: false, // for the sake of this project hasReacheMax is always going to be false
          ));
        }
      } catch (_) {
        emit(state.copyWith(status: AlbumStatus.failure));
      }
    });
  }
}
