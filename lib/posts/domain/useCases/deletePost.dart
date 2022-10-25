import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../repo/postRepo.dart';



class DeletePostUseCase {
  final PostRepo repo ;
  
  DeletePostUseCase( this.repo,
  );
   Future<Either<Failure, Unit>> call  (int postId) async {

    return await repo.deletePost(postId);
   }
}
