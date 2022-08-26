import 'dart:convert';

import 'package:equatable/equatable.dart';

class PhotoResponse extends Equatable {
  late int albumId;
  late int id;
  late String title;
  late String url;
  late String thumbnailUrl;

  PhotoResponse(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  PhotoResponse.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }

  @override
  List<Object?> get props => [albumId, id, title, url, thumbnailUrl];
}

List<PhotoResponse> photoResponseFromMap(String str) =>
    List<PhotoResponse>.from(
        json.decode(str).map((x) => PhotoResponse.fromJson(x)));

String photoResponseToMap(List<PhotoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
