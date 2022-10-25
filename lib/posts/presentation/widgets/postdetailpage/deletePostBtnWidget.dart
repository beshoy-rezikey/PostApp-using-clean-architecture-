import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbarMessage.dart';
import '../../../../core/widgets/loadingWidget.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../pages/postPage.dart';
import 'deleteDialogWidegt.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
        onPressed: () {
          return deleteDialog(context, postId);
        },
        icon: Icon(Icons.delete_outline),
        label: Text('Delete'));
  }
  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState)
            {
              return AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDailogWidget(postId:postId);
          },

          listener: (context, state) {
            if (state is MessageDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(
                  message: state.message, context: context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => PostPage(),
                ),
                    (route) => false,
              );
            } else if (state is ErrorAddDeleteUpdatePostState)
            {
              Navigator.pop(context);
              SnackBarMessage().showERRORSnackBar(message: state.message, context: context);

            }
          },
        );
      },
    );
  }
}
