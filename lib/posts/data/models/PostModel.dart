

import '../../domain/entities/postEntity.dart';

class PostModel extends Post {
  PostModel({int? id, required String title, required String body})
      : super(id: id, title: title, body: body);


  factory PostModel.fromJson ( Map <String ,dynamic> json)
  {
    return PostModel(id: json['id'], title: json['title'], body:json['body']);
  }

  Map<String ,dynamic> toJson (){

    return {'id':id , 'body':body , 'title':title};
  }
  
}