import 'package:dartz/dartz.dart';

import '../../../../core/data/error.dart';
import '../../../../core/data/exception.dart';
import '../../../../core/data/network_info.dart';
import '../data_sources/photo_data_src.dart';
import '../model/response/photo_response.dart';

abstract class PhotoRepo {
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos();
}

class PhotoRepoImpl extends PhotoRepo {
  final NetworkInfo networkInfo;
  final PhotoDataSrc photoDataSrc;

  PhotoRepoImpl({required this.photoDataSrc, required this.networkInfo});

  @override
  Future<Either<Failure, List<PhotoResponse>?>>? getPhotos() async {
    if (await networkInfo.isConnected ?? false) {
      try {
        final remote = await photoDataSrc.getPhotos();
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
