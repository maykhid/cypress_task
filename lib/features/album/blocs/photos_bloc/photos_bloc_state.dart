part of 'photos_bloc_bloc.dart';

enum PhotosStatus { initial, success, failure } // possible states for our calls

class PhotosBlocState extends Equatable {
  const PhotosBlocState({
    this.status = PhotosStatus.initial,
    this.photos = const <PhotoResponse>[],
  });

  final PhotosStatus status;
  final List<PhotoResponse> photos;

  PhotosBlocState copyWith({
    PhotosStatus? status,
    List<PhotoResponse>? photos,
  }) {
    return PhotosBlocState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
    );
  }

  @override
  String toString() {
    return '''PhotosBlocState { status: $status, photos: ${photos.length} }''';
  }

  @override
  List<Object?> get props => [status, photos];
}
