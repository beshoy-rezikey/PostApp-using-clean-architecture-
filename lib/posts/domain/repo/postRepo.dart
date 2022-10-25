import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/postEntity.dart';

abstract class PostRepo {
  Future<Either<Failure, List<Post>>> getAllPost();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatepost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}
