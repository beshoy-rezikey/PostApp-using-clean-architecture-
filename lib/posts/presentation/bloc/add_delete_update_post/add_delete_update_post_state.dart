part of 'add_delete_update_post_bloc.dart';

@immutable
  abstract class AddDeleteUpdatePostState  extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}
class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}
class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
final String message; 
  ErrorAddDeleteUpdatePostState({
    required this.message,
  });
  List<Object?> get props => [message];

}
class MessageDeleteUpdatePostState extends AddDeleteUpdatePostState {
final String message; 
  MessageDeleteUpdatePostState({
    required this.message,
  });
  List<Object?> get props => [message];

}



