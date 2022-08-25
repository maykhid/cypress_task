import 'package:cypress_task/core/data/exception.dart';
import 'package:cypress_task/features/album/data/model/response/photo_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PhotoLocalDataSrc {
  Future<List<PhotoResponse>>? getCachedPhotos();
  Future<void> cachePhotos(List<PhotoResponse>? response);
}

const photoStorageKey = '___PHOTO__KEY___';

class PhotoLocalDataSrcImpl implements PhotoLocalDataSrc {
  final SharedPreferences prefs;

  PhotoLocalDataSrcImpl({required this.prefs});

  @override
  Future<List<PhotoResponse>>? getCachedPhotos() {
    final jsonResponse = prefs.getString(photoStorageKey);

    if (jsonResponse != null) {
      return Future.value(photoResponseFromMap(jsonResponse));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePhotos(List<PhotoResponse>? response) {
    return prefs.setString(photoStorageKey, photoResponseToMap(response!));
  }
}
