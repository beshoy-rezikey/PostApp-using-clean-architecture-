import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/strings/failure.dart';
import '../../../../core/strings/messages.dart';
import '../../../domain/entities/postEntity.dart';
import '../../../domain/useCases/addPost.dart';
import '../../../domain/useCases/deletePost.dart';
import '../../../domain/useCases/updatePost.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final faluireOrDoneMessage = await addPost(event.post);
   emit( _eitherDoneMessageOrErrorState(faluireOrDoneMessage, ADD_SUCCESS_MESSAGE));

      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final faluireOrDoneMessage = await updatePost(event.post);
      emit( _eitherDoneMessageOrErrorState(faluireOrDoneMessage, UPDATE_SUCCESS_MESSAGE)) ;
      }
      else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final faluireOrDoneMessage = await deletePost(event.postId);
      emit(_eitherDoneMessageOrErrorState(faluireOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
  return either.fold((faluire) => 
    ErrorAddDeleteUpdatePostState(
                      message: _mapFaliureToMessage(faluire))
  , (_) => MessageDeleteUpdatePostState(
                      message: message));
  }

  String _mapFaliureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'unexpected error , please try again later ';
    }
  }
}
