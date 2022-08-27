import 'dart:developer';

import '../../../../../core/data/exception.dart';
import '../../model/response/photo_response.dart';
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
      log('Error retrieving cached photos...');
      throw CacheException();
    }
  }

  @override
  Future<void> cachePhotos(List<PhotoResponse>? response) {
    log('Photos stored in cache successfully...');
    return prefs.setString(photoStorageKey, photoResponseToMap(response!));
  }
}
