import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/postEntity.dart';
import '../repo/postRepo.dart';

class GetAllPostsUseCase {
final PostRepo repo ;

  GetAllPostsUseCase(this.repo);  
  

  Future<Either<Failure, List<Post>>> call () async {
return await repo.getAllPost();


  }

}


