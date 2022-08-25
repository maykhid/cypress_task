import 'package:cypress_task/features/album/data/model/response/album_response.dart';

abstract class AlbumDataSrc {
  Future<List<AlbumResponse>>? getAlbums();
}
