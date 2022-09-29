import '../utils/config.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  /// get call
  static Future<http.Response> get(String pointer,
      [Map<String, dynamic>? queryParameters]) async {
    late final Uri url;

    if (queryParameters != null) {
      url = Uri.https('jsonplaceholder.typicode.com', pointer, queryParameters);
    } else {
      url = Uri.parse('$apiBaseUrl$pointer');
    }

    

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        return res;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
