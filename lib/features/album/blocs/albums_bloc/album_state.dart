part of 'album_bloc.dart';

enum AlbumStatus { initial, success, failure }

class AlbumState extends Equatable {
   AlbumState({
    this.status = AlbumStatus.initial,
    this.albums = const <AlbumResponse>[],
    this.hasReachedMax = false,
  });

  final AlbumStatus status;
  final List<AlbumResponse> albums;
  bool? hasReachedMax;

  AlbumState copyWith({
    AlbumStatus? status,
    List<AlbumResponse>? albums,
    bool? hasReachedMax,
  }) {
    return AlbumState(
      status: status ?? this.status,
      albums: albums ?? this.albums,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''AlbumState { status: $status, hasReachedMax: $hasReachedMax, albums: ${albums.length} }''';
  }

  @override
  List<Object?> get props => [status, albums, hasReachedMax];
}
