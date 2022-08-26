import 'dart:convert';

import 'package:equatable/equatable.dart';

class AlbumResponse extends Equatable{
  late int userId;
  late int id;
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