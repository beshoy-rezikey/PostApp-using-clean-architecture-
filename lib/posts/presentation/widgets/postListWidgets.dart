import 'package:flutter/material.dart';
import 'package:postapp2/posts/presentation/pages/PostDetailpage.dart';

import '../../domain/entities/postEntity.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
          ),
          subtitle: Text(posts[index].body,style: TextStyle(fontSize: 16),),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => PostDetailPage(post: posts[index]),));

          },
        );

      },
      separatorBuilder: (context, index) => Divider(thickness: 1,),
      itemCount: posts.length,
    );
  }
}
