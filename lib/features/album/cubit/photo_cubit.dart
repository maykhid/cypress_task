import 'package:bloc/bloc.dart';
import 'package:cypress_task/features/album/data/repositories/photo_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../dependency_injector.dart';
import '../data/model/response/photo_response.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit({PhotoRepo? photoRepo})
      : _photoRepo = photoRepo ?? di(),
        super(PhotoInitial());

  final PhotoRepo? _photoRepo;

  void getPhotos() async {
    emit(PhotoLoading());

    final response = await _photoRepo!.getPhotos();
    emit(
        response!.fold((l) => PhotoFailure(), (r) => PhotoLoaded(response: r)));
  }
}
