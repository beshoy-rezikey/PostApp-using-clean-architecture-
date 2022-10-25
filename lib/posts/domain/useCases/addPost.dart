import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/postEntity.dart';
import '../repo/postRepo.dart';


class AddPostUseCase {
   final PostRepo repo ;

  AddPostUseCase(
     this.repo,
  );

  Future<Either<Failure, Unit>> call(Post post)async {

    return  await repo.addPost(post);
  }
  
}
