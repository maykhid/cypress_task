import 'package:http/http.dart' as http;

import 'package:cypress_task/features/album/data/data_sources/album_data_src.dart';

import '../../../../../core/data/api.dart';
import '../../../../../core/utils/config.dart';
import '../../model/response/album_response.dart';

class AlbumRemoteDataSrcImpl extends AlbumDataSrc {
  @override
  Future<List<AlbumResponse>>? getAlbums() async {
    try {
      final res = await ApiRequest.get(albumPointer);
      return albumResponseFromMap(res.body);
    } catch (e) {
      throw Exception();
    }
  }
}
