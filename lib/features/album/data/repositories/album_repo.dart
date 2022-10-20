import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/data/error.dart';
import '../../../../core/data/exception.dart';
import '../../../../core/data/network_info.dart';
import '../data_sources/local/album_local.dart';
import '../data_sources/remote/album_remote.dart';
import '../model/response/album_response.dart';

abstract class AlbumRepo {
  Future<Either<Failure, List<AlbumResponse>?>>? getAlbums();
}

class AlbumRepoImpl extends AlbumRepo {
  final NetworkInfo networkInfo;
  final AlbumRemoteDataSrc albumRemoteDataSrc;
  final AlbumLocalDataSrc albumLocalDataSrc;

  AlbumRepoImpl(
      {required this.albumRemoteDataSrc,
      required this.networkInfo,
      required this.albumLocalDataSrc});

  @override
  Future<Either<Failure, List<AlbumResponse>?>>? getAlbums() async {
    // Only load data from the api if there is internet connection and cache is empty if not
    // then get cached data
    if (await networkInfo.isConnected && albumLocalDataSrc.boxIsEmpty()) {
      try {
        final remote = await albumRemoteDataSrc.getAlbums();
        await albumLocalDataSrc.cacheAlbum(remote);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // if no internet, and cache is not empty
      // try getting data from cache, but if cache is empty and there's internet connection
      // then get from api
      try {
        List<AlbumResponse>? local = await albumLocalDataSrc.getCachedAlbums();
        if (local == null && await networkInfo.isConnected) {
          log('Retrieving cached albums failed - Getting photos from remote data source');
          local = await albumRemoteDataSrc.getAlbums(); // getting live data
          await albumLocalDataSrc.cacheAlbum(local); // caching new live data
        }
        return Right(local);
      } on CacheException {
        return Left(CacheFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
