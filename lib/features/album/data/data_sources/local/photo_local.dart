import 'dart:developer';

import 'package:hive/hive.dart';

import '../../../../../core/data/exception.dart';
import '../../model/response/photo_response.dart';

abstract class PhotoLocalDataSrc {
  Future<List<PhotoResponse>>? getCachedPhotos(String albumId);
  Future<void> cachePhotos(List<PhotoResponse>? response, String albumId);
  bool boxIsEmpty(String albumId);
}

class PhotoLocalDataSrcImpl implements PhotoLocalDataSrc {
  final Box photoBox;

  PhotoLocalDataSrcImpl({required this.photoBox});

  @override
  Future<List<PhotoResponse>>? getCachedPhotos(String albumId) {
    if (boxIsClosed) {
      throw CacheException();
    }
    log('Album id $albumId ${photoBox.get(albumId)[1]}');
    return Future.value(List<PhotoResponse>.from(photoBox.get(albumId)));
  }

  @override
  Future<void> cachePhotos(
      List<PhotoResponse>? response, String albumId) async {
    if (boxIsClosed) {
      throw CacheException();
    }

    await photoBox.put(albumId, response!);
  }

  @override
  bool boxIsEmpty(String albumId) {
    if (boxIsClosed) {
      throw CacheException();
    }

    return photoBox.isEmpty;
  }

  bool get boxIsClosed => !(photoBox.isOpen);
}
