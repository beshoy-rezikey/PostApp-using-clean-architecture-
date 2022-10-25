import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postapp2/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';

import '../../../domain/entities/postEntity.dart';

class DeleteDailogWidget extends StatelessWidget {

  final int postId ;
  const DeleteDailogWidget({Key? key, required this.postId,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure ?'),
      actions: [
        TextButton(onPressed:() => Navigator.pop(context), child: Text('No')),
        TextButton(onPressed: () {
          BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(DeletePostEvent(postId: postId));
        }, child: Text('YES')),
      ],
    );
  }
}
