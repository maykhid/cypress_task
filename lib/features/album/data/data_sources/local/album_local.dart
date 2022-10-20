import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import '../../model/response/album_response.dart';

import '../../../../../core/data/exception.dart';

abstract class AlbumLocalDataSrc {
  Future<List<AlbumResponse>>? getCachedAlbums();
  Future<void> cacheAlbum(List<AlbumResponse>? response);
  bool boxIsEmpty();
}

const albumStorageKey = '___ALBUM__KEY___';

class AlbumLocalDataSrcImpl implements AlbumLocalDataSrc {
  final Box albumBox;

  AlbumLocalDataSrcImpl({required this.albumBox});

  @override
  Future<List<AlbumResponse>>? getCachedAlbums() {
    log('Retrieving albums - cached data...');
    if (boxIsClosed) {
      throw CacheException();
    }
    return Future.value(List<AlbumResponse>.from(albumBox.get(albumStorageKey)));
  }

  @override
  Future<void> cacheAlbum(List<AlbumResponse>? response) async {
    log('Album stored in cache successfully...');
    if (boxIsClosed) {
      throw CacheException();
    }

    await albumBox.put(albumStorageKey, response!);
  }

  @override
  bool boxIsEmpty() {
    if (boxIsClosed) {
      throw CacheException();
    }

    return albumBox.isEmpty;
  }

  bool get boxIsClosed => !(albumBox.isOpen);
}
