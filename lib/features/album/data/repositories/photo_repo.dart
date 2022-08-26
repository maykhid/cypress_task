import '../data_sources/local/photo_local.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/error.dart';
import '../../../../core/data/exception.dart';
import '../../../../core/data/network_info.dart';
import '../data_sources/remote/photo_remote.dart';
import '../model/response/photo_response.dart';

abstract class PhotoRepo {
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos();
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
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos() async {
    if (await networkInfo.isConnected ?? false) {
      try {
        final remote = await photoRemoteDataSrc.getPhotos();
        await photoLocalDataSrc.cachePhotos(remote);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final local = await photoLocalDataSrc.getCachedPhotos();
        return Right(local);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
