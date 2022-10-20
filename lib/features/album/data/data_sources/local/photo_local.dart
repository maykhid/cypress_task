import 'dart:developer';

import 'package:hive/hive.dart';

import '../../../../../core/data/exception.dart';
import '../../model/response/photo_response.dart';

abstract class PhotoLocalDataSrc {
  Future<AllPhotoResponses?>? getCachedPhotos(String albumId);
  Future<void> cachePhotos(AllPhotoResponses? response, String albumId);
  bool boxIsEmpty(String albumId);
}

class PhotoLocalDataSrcImpl implements PhotoLocalDataSrc {
  final Box<AllPhotoResponses> photoBox;

  PhotoLocalDataSrcImpl({required this.photoBox});

  @override
  Future<AllPhotoResponses?>? getCachedPhotos(String albumId) {
    log('Retrieving photos - cached data...');
    if (boxIsClosed) {
      throw CacheException();
    }
    // log('Album id $albumId ${photoBox.get(albumId)!.photoResponses}');
    return Future.value(photoBox.get(albumId));
  }

  @override
  Future<void> cachePhotos(
      AllPhotoResponses? response, String albumId) async {
    if (boxIsClosed) {
      throw CacheException();
    }
    log('Photos stored in cache successfully...');
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
