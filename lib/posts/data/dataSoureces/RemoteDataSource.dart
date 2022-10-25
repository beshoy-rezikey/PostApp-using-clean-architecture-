import 'dart:convert';


import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/excepition.dart';
import '../models/PostModel.dart';


abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int PostId);
  Future<Unit> updatepost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const BaseUrl = 'https://jsonplaceholder.typicode.com';

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImplement({
    required this.client,
  });

  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(Uri.parse(BaseUrl + '/posts/'),
        headers: {'Content-Type': ' application/json'});
    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerEXception();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.post(Uri.parse(BaseUrl +  "/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerEXception();
    }
  }

  @override
  Future<Unit> deletePost(int PostId) async {
    final response = await client.delete(
        Uri.parse(BaseUrl + '/posts/${PostId.toString()}'),
      headers: {"Content-Type": "application/json"},);
        if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerEXception();
    }
  }

  @override
  Future<Unit> updatepost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'title':postModel.title,
      'body':postModel.body,
    };
    final   response =  await client.put(Uri.parse(BaseUrl+'/posts/$postId'),body: body);
  if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerEXception();
    }  }
}
