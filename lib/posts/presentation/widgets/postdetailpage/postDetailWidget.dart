import 'package:flutter/material.dart';

import 'package:postapp2/posts/domain/entities/postEntity.dart';


import 'UpdatePostDetailWidget.dart';
import 'deletePostBtnWidget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(children: [
        Text(
          post.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(
          height: 50,
        ),
        Text(
          post.title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Divider(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          UpdatePostBtnWidegt(post:post),


          DeletePostBtnWidget (postId: post.id!),

        ]),

      ]),
    );
  }


}
