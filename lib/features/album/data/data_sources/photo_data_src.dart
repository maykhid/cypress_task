import '../model/response/photo_response.dart';

abstract class PhotoDataSrc {
  Future<List<PhotoResponse>>? getPhotos();
}
