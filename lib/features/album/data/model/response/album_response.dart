// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'album_response.g.dart';

@HiveType(typeId: 1)
class AlbumResponse extends Equatable{
  @HiveField(0)
  late int userId;
  @HiveField(1)
  late int id;
  @HiveField(2)
  late String title;

  AlbumResponse({required this.userId, required this.id, required this.title});

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
  
  @override
  List<Object?> get props => [id, title, userId];
}

List<AlbumResponse> albumResponseFromMap(String str) => List<AlbumResponse>.from(json.decode(str).map((x) => AlbumResponse.fromJson(x)));

String albumResponseToMap(List<AlbumResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));