import 'package:cypress_task/core/data/error.dart';
import 'package:cypress_task/core/data/exception.dart';
import 'package:cypress_task/features/album/data/model/response/album_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/network_info.dart';
import '../data_sources/album_data_src.dart';

abstract class AlbumRepo {
  Future<Either<Failure, List<AlbumResponse>?>>? getAlbums();
}

class AlbumRepoImpl extends AlbumRepo {
  final NetworkInfo networkInfo;
  final AlbumDataSrc albumDataSrc;

  AlbumRepoImpl({required this.albumDataSrc, required this.networkInfo});

  @override
  Future<Either<Failure, List<AlbumResponse>?>>? getAlbums() async {
    if (await networkInfo.isConnected ?? false) {
      try {
        final remote = await albumDataSrc.getAlbums();
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      //TODO: load from db
      return Left(NetworkFailure());
    }
  }
}
