
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:postapp2/posts/data/models/PostModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/excepition.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cashPosts(List<PostModel> postModel);
}
const CASHED_POST ='CASHED_POST';
class LocalDataSourceImplement implements LocalDataSource {
  @override
  SharedPreferences sharedPreferences;
  LocalDataSourceImplement({
    required this.sharedPreferences,
  });
  Future<Unit> cashPosts(List<PostModel> postModels) {
    List postModelToJson = postModels.map <Map<String,dynamic>>((postModel) {
      return postModel.toJson();
    }).toList();
        
    sharedPreferences.setString(CASHED_POST, jsonEncode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {

    final jsonString = sharedPreferences.getString(CASHED_POST);
    if (jsonString != null) {
      List decodeJsonData = jsonDecode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCachException();
    }
  }
}
