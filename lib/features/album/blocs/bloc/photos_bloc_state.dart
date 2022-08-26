part of 'photos_bloc_bloc.dart';

enum PhotosStatus { initial, success, failure }

class PhotosBlocState extends Equatable {
  PhotosBlocState({
    this.status = PhotosStatus.initial,
    this.photos = const <PhotoResponse>[],
    this.hasReachedMax = false,
  });

  final PhotosStatus status;
  final List<PhotoResponse> photos;
  bool? hasReachedMax;

  PhotosBlocState copyWith({
    PhotosStatus? status,
    List<PhotoResponse>? photos,
    bool? hasReachedMax,
  }) {
    return PhotosBlocState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PhotosBlocState { status: $status, hasReachedMax: $hasReachedMax, photos: ${photos.length} }''';
  }

  @override
  List<Object?> get props => [status, photos, hasReachedMax];
}
