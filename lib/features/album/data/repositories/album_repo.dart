import 'package:cypress_task/core/data/error.dart';
import 'package:cypress_task/core/data/exception.dart';
import 'package:cypress_task/features/album/data/data_sources/local/album_local.dart';
import 'package:cypress_task/features/album/data/model/response/album_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/network_info.dart';
import '../data_sources/remote/album_remote.dart';

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
    if (await networkInfo.isConnected ?? false) {
      try {
        final remote = await albumRemoteDataSrc.getAlbums();
        await albumLocalDataSrc.cacheAlbum(remote);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final local = await albumLocalDataSrc.getCachedAlbums();
        return Right(local);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
