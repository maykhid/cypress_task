import 'dart:developer';

import '../../../../../core/data/exception.dart';
import '../../model/response/photo_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PhotoLocalDataSrc {
  Future<List<PhotoResponse>>? getCachedPhotos(String albumId);
  Future<void> cachePhotos(List<PhotoResponse>? response, String albumId);
}

const photoStorageKey = '___PHOTO__KEY___';

class PhotoLocalDataSrcImpl implements PhotoLocalDataSrc {
  final SharedPreferences prefs;

  PhotoLocalDataSrcImpl({required this.prefs});

  @override
  Future<List<PhotoResponse>>? getCachedPhotos(String albumId) {
    final jsonResponse = prefs.getString('$photoStorageKey$albumId');

    if (jsonResponse != null) {
      log('Retrieving cached photos...');
      return Future.value(photoResponseFromMap(jsonResponse));
    } else {
      log('Error retrieving cached photos...');
      throw CacheException();
    }
  }

  @override
  Future<void> cachePhotos(List<PhotoResponse>? response, String albumId) {
    log('Photos stored in cache successfully...');
    return prefs.setString('$photoStorageKey$albumId', photoResponseToMap(response!));
  }
}
