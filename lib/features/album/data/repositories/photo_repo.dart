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

  @override
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos(String albumId) async {
    // Try loading data from the api if there is internet connection if not
    // then get cached data
    // if for some reason api call fails get data from cache
    if (await networkInfo.isConnected ?? false) {
      try {
        final remote = await photoRemoteDataSrc.getPhotos(albumId);
        await photoLocalDataSrc.cachePhotos(remote, albumId);
        return Right(remote);
      } on ServerException {
        try {
          final local = await photoLocalDataSrc.getCachedPhotos(albumId);
          return Right(local);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    } else {
      // if no internet get cached data and throw cache exception on error
      try {
        final local = await photoLocalDataSrc.getCachedPhotos(albumId);
        return Right(local);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
