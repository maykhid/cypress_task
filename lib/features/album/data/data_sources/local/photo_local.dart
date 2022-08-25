import 'package:cypress_task/features/album/data/data_sources/remote/picture_data_src.dart';
import 'package:cypress_task/features/album/data/model/response/photo_response.dart';

import '../photo_data_src.dart';

class PhotoLocalDataSrcImpl implements PhotoDataSrc{
  @override
  Future<List<PhotoResponse>>? getPhotos() {
    // TODO: implement getPhotos
    throw UnimplementedError();
  }

}