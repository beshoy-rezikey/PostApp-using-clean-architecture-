part of 'add_delete_update_post_bloc.dart';

@immutable
 abstract  class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
 } 
class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post ;
  AddPostEvent({
    required this.post,
  });
  // TODO: implement props
  List<Object?> get props => [Post];
 } 

 class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post post ;
  UpdatePostEvent({
    required this.post,
  });
  // TODO: implement props
  List<Object?> get props => [Post];
 } 

 class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int postId ;
  DeletePostEvent({
    required this.postId,
  });
  // TODO: implement props
  List<Object?> get props => [postId];
 } 
 
 
