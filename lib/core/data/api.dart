import 'dart:convert';

import '../utils/config.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  /// get call
  static Future<Map<String, dynamic>> get(String pointer) async {
    final url = Uri.parse('$apiBaseUrl/$pointer');
    try {
      final res = await http.get(url);
      Map<String, dynamic> response = jsonDecode(res.body);
      return response;
    } catch (e) {
      throw Exception();
    }
  }
}
