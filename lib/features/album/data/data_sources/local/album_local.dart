import 'package:cypress_task/features/album/data/model/response/album_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/exception.dart';

abstract class AlbumLocalDataSrc {
  Future<List<AlbumResponse>>? getCachedAlbums();
  Future<void> cacheAlbum(List<AlbumResponse> response);
}

const albumStorageKey = '___ALBUM__KEY___';

class AlbumLocalDataSrcImpl implements AlbumLocalDataSrc {
  final SharedPreferences prefs;

  AlbumLocalDataSrcImpl({required this.prefs});

  @override
  Future<List<AlbumResponse>>? getCachedAlbums() {
    final jsonResponse = prefs.getString(albumStorageKey);

    if (jsonResponse != null) {
      return Future.value(albumResponseFromMap(jsonResponse));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAlbum(List<AlbumResponse> response) {
    return prefs.setString(albumStorageKey, albumResponseToMap(response));
  }
}
