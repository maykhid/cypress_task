import 'package:cypress_task/features/album/data/model/response/photo_response.dart';

import '../../../../../core/data/api.dart';
import '../../../../../core/utils/config.dart';
import '../photo_data_src.dart';

class PhotoRemoteDataSrcImpl implements PhotoDataSrc{
  @override
  Future<List<PhotoResponse>>? getPhotos() async {
    try {
      final res = await ApiRequest.get(photoPointer);
      return photoResponseFromMap(res.body);
    } catch (e) {
      throw Exception();
    }
  }
  
}