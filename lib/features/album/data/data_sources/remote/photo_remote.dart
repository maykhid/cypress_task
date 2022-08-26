import '../../../../../core/data/api.dart';
import '../../../../../core/data/exception.dart';
import '../../../../../core/utils/config.dart';
import '../../model/response/photo_response.dart';



abstract class PhotoRemoteDataSrc {
  Future<List<PhotoResponse>>? getPhotos();
}

class PhotoRemoteDataSrcImpl implements PhotoRemoteDataSrc{
  @override
  Future<List<PhotoResponse>>? getPhotos() async {
    try {
      final res = await ApiRequest.get(photoPointer);
      return photoResponseFromMap(res.body);
    } catch (e) {
      throw ServerException();
    }
  }
  
}