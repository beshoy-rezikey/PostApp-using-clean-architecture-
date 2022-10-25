import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../core/error/excepition.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/networkInfo.dart';
import '../../domain/entities/postEntity.dart';
import '../../domain/repo/postRepo.dart';
import '../dataSoureces/LocalDataSource.dart';
import '../dataSoureces/RemoteDataSource.dart';
import '../models/PostModel.dart';

typedef Future<Unit> updateOrDeleteoradd();

class PostRepoImplement implements PostRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepoImplement( 
      {required this.remoteDataSource, required this.localDataSource,required this.networkInfo,});

  @override
  Future<Either<Failure, List<Post>>> getAllPost() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPost();
        localDataSource.cashPosts(remotePosts);
        return right(remotePosts);
      } on ServerEXception {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPost = await localDataSource.getCashedPosts();
        return right(localPost);
      } on EmptyCachException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel( title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatepost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.updatepost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
     updateOrDeleteoradd  updateOrDeleteoradd) async {
    if (await networkInfo.isConnected) {
      try {
        await updateOrDeleteoradd();
        return right(unit);
      } on ServerEXception {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
