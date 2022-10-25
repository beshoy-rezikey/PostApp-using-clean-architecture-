import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/widgets/loadingWidget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/messageDisplayWidget.dart';
import '../widgets/postListWidgets.dart';
import 'addUpdatePage.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildApppar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildApppar() =>
      AppBar(
        title: Text('Posts'),
      );
}

Widget _buildBody() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsStates) {
          return LoadingWidget();
        } else if (state is LoadadedPostsStates) {
          return RefreshIndicator(child: PostListWidget(posts: state.posts),
            onRefresh: () => _onRefersh(context),);
        } else if (state is ErrorPostsStates) {
          return MessageDisplayWidget(message: state.message);
        }
        return LoadingWidget();
      },
    ),
  );
}

Future<void> _onRefersh(BuildContext context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}

Widget _buildFloatingBtn(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PostAddUpdatePage( isUpdatePost: false),));
    },
    child: Icon(Icons.add_sharp),
  );
}
