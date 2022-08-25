import 'package:bloc/bloc.dart';
import 'package:cypress_task/features/album/data/model/response/album_response.dart';
import 'package:cypress_task/features/album/data/repositories/album_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit({AlbumRepo? albumRepo})
      : _albumRepo = albumRepo,
        super(AlbumInitial());

  final AlbumRepo? _albumRepo;

  void getAlbums() async {
    emit(AlbumLoading());

    final response = await _albumRepo!.getAlbums();
    emit(response!.fold((l) => AlbumFailure(), (r) => AlbumLoaded(response: r)));
  }
}
