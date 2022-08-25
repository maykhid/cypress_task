part of 'photo_cubit.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}
class PhotoLoaded extends PhotoState {
  final List<PhotoResponse>? response;

  const PhotoLoaded({this.response = const <PhotoResponse>[]});

  @override
  List<Object?> get props => [response];
}

class PhotoFailure extends PhotoState {}