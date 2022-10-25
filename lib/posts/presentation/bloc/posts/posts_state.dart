part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  const PostsState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsStates extends PostsState {}

class LoadadedPostsStates extends PostsState {
  final List<Post> posts;

  LoadadedPostsStates({required this.posts});
  @override
  // TODO: implement props
  List<Object?> get props => [posts];
}

class ErrorPostsStates extends PostsState {
  final String message;

  ErrorPostsStates({required this.message});

  // TODO: implement props
  List<Object?> get props => [message];
}
