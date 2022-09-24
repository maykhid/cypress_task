part of 'photos_bloc_bloc.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();

  @override
  List<Object> get props => [];
}

class PhotosFetched extends PhotosEvent {
  const PhotosFetched([this.albumid]);
  final String? albumid;
  @override
  List<Object> get props => [];
}
