import 'package:bloc/bloc.dart';
import '../../data/data_sources/local/photo_local.dart';
import '../../data/repositories/photo_repo.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/response/photo_response.dart';

part 'photos_bloc_event.dart';
part 'photos_bloc_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosBlocState> {
  PhotosBloc({PhotoRepo? photoRepo, PhotoLocalDataSrc? photoLocalDataSrc})
      : super(const PhotosBlocState()) {
    on<PhotosEvent>((event, emit) async {

      if (state.status == PhotosStatus.initial) {
        final photos = await photoRepo!.getPhotos();
        return emit(photos!.fold(
            (l) => state.copyWith(status: PhotosStatus.failure),
            (r) => state.copyWith(
                status: PhotosStatus.success,
                photos: r,
                // hasReachedMax: false,
                )));
      }

    });
  }
}
