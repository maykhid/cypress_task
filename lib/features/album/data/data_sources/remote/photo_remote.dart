import 'dart:developer';

import '../../../../../core/data/api.dart';
import '../../../../../core/data/exception.dart';
import '../../../../../core/utils/config.dart';
import '../../model/response/photo_response.dart';

abstract class PhotoRemoteDataSrc {
  Future<AllPhotoResponses>? getPhotos(String albumId);
}

class PhotoRemoteDataSrcImpl implements PhotoRemoteDataSrc {
  @override
  Future<AllPhotoResponses>? getPhotos(String albumId) async {
    var queryParameters = {'albumId': albumId};
    try {
      log('Retrieving photos - remote data...');
      final res = await ApiRequest.get(photoPointer, queryParameters);
      return AllPhotoResponses.fromJson(res.body);
    } catch (e) {
      log('Error fetching photos...');
      throw ServerException();
    }
  }
}
