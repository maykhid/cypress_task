import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoInitial());
}
