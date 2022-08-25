part of 'album_cubit.dart';

@immutable
abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object?> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<AlbumResponse>? response;

  const AlbumLoaded({this.response = const <AlbumResponse>[]});

  @override
  List<Object?> get props => [response];
}

class AlbumFailure extends AlbumState {}
