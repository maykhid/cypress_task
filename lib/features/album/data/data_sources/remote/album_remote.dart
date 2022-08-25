import '../../../../../core/data/api.dart';
import '../../../../../core/data/exception.dart';
import '../../../../../core/utils/config.dart';
import '../../model/response/album_response.dart';

import 'package:cypress_task/features/album/data/model/response/album_response.dart';

abstract class AlbumRemoteDataSrc {
  Future<List<AlbumResponse>>? getAlbums();
}

class AlbumRemoteDataSrcImpl extends AlbumRemoteDataSrc {
  @override
  Future<List<AlbumResponse>>? getAlbums() async {
    try {
      final res = await ApiRequest.get(albumPointer);
      return albumResponseFromMap(res.body);
    } catch (e) {
      throw ServerException();
    }
  }
}
