import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postapp2/posts/presentation/pages/postPage.dart';


import '../../../core/util/snackbarMessage.dart';
import '../../../core/widgets/loadingWidget.dart';
import '../../domain/entities/postEntity.dart';
import '../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../widgets/PostAddUpdatePage/formWidget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() =>
      AppBar(title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'));

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return LoadingWidget();
            } else return
            FormWidget(
                isUpdatePost: isUpdatePost,
                post: isUpdatePost ? post : null);
          },
          listener: (context, state) {
            if (state is MessageDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => PostPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
               SnackBarMessage().showERRORSnackBar(message: state.message, context: context);
            }
          },
        ),
      ),
    );
  }
}
