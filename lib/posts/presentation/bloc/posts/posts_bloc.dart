import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


import '../../../../core/error/failure.dart';
import '../../../../core/strings/failure.dart';
import '../../../domain/entities/postEntity.dart';
import '../../../domain/useCases/getAllPosts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {

    on<PostsEvent>((event, emit) async {

      if (event is GetAllPostsEvent) {
        emit(LoadingPostsStates());
        final faliureOrPosts = await getAllPosts();
        emit(_mapFaliureOrPostToState(faliureOrPosts));
        
      } 
      else if (event is RefreshPostsEvent) {
        emit(LoadingPostsStates());
        final faliureOrPosts = await getAllPosts();
        emit(_mapFaliureOrPostToState(faliureOrPosts));
      }
    });
  }

  PostsState _mapFaliureOrPostToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsStates(message: _mapFaliureToMessage(failure)),
        (posts) => LoadadedPostsStates(posts: posts));
  }

  String _mapFaliureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      default:
        return 'faiilure is : ${failure.toString()} ';
    }
  }
}
