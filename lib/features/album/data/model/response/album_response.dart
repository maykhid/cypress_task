import 'dart:convert';

class AlbumResponse {
  int? userId;
  int? id;
  String? title;

  AlbumResponse({this.userId, this.id, this.title});

  AlbumResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

List<AlbumResponse> albumResponseFromMap(String str) => List<AlbumResponse>.from(json.decode(str).map((x) => AlbumResponse.fromJson(x)));

String albumResponseToMap(List<AlbumResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));