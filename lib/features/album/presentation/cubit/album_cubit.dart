import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumInitial());
}
