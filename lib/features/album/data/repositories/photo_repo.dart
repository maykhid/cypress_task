import 'dart:developer';

import '../data_sources/local/photo_local.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/error.dart';
import '../../../../core/data/exception.dart';
import '../../../../core/data/network_info.dart';
import '../data_sources/remote/photo_remote.dart';
import '../model/response/photo_response.dart';

abstract class PhotoRepo {
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos(String albumId);
}

class PhotoRepoImpl extends PhotoRepo {
  final NetworkInfo networkInfo;
  final PhotoRemoteDataSrc photoRemoteDataSrc;
  final PhotoLocalDataSrc photoLocalDataSrc;

  PhotoRepoImpl({
    required this.photoRemoteDataSrc,
    required this.networkInfo,
    required this.photoLocalDataSrc,
  });

  /// This [getphotos] method has been built the way it is to limit accessing the placeholder API un-necessarily.
  /// Due to the limits imposed on placeholder API, you cannot make excessive calls to their API.
  /// An error occurs when you have exceeded your given limit and you're restricted.
  /// 
  /// Side Note: It is being assumed that new updates to the photo API is unlikely, so getting
  /// fresh data isn't needed.
  @override
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos(
      String albumId) async {
    // Only load data from the api if there is internet connection and cache is empty if not
    // then get cached data

    if (await networkInfo.isConnected &&
        photoLocalDataSrc.boxIsEmpty(albumId)) {
      try {
        final remote = await photoRemoteDataSrc.getPhotos(albumId);
        await photoLocalDataSrc.cachePhotos(remote, albumId);
        return Right(remote!.photoResponses);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // if no internet connection and cache is not empty
      // try getting data from cache, but if cache is empty and there's internet connection
      // then get from api
      try {
        AllPhotoResponses? local =
            await photoLocalDataSrc.getCachedPhotos(albumId);

        //
        if (local == null && await networkInfo.isConnected) {
          log('Retrieving cached photos failed - Getting photos from remote data source');
          local = await photoRemoteDataSrc.getPhotos(albumId); // getting live data
          await photoLocalDataSrc.cachePhotos(local, albumId); // caching new live data
        }
        return Right(local!.photoResponses);
      } on CacheException {
        return Left(CacheFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
