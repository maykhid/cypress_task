// ignore_for_file: must_be_immutable

import 'dart:convert';

// import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'photo_response.g.dart';

@HiveType(typeId: 0)
class PhotoResponse extends HiveObject {
  @HiveField(0)
  late int albumId;
  @HiveField(1)
  late int id;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String url;
  @HiveField(4)
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

  // @override
  // List<Object?> get props => [albumId, id, title, url, thumbnailUrl];
}

@HiveType(typeId: 3)
class AllPhotoResponses extends HiveObject {
  @HiveField(1)
  List<PhotoResponse> photoResponses;

  AllPhotoResponses({required this.photoResponses});

  factory AllPhotoResponses.fromJson(String str) => AllPhotoResponses(
      photoResponses: List<PhotoResponse>.from(
          json.decode(str).map((x) => PhotoResponse.fromJson(x))));
}

// List<PhotoResponse> photoResponseFromMap(String str) =>
//     List<PhotoResponse>.from(
//         json.decode(str).map((x) => PhotoResponse.fromJson(x)));

String photoResponseToMap(List<PhotoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
