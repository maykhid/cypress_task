import 'dart:convert';

class PhotoResponse {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoResponse(
      {this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  PhotoResponse.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}

List<PhotoResponse> photoResponseFromMap(String str) => List<PhotoResponse>.from(json.decode(str).map((x) => PhotoResponse.fromJson(x)));

String photoResponseToMap(List<PhotoResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));