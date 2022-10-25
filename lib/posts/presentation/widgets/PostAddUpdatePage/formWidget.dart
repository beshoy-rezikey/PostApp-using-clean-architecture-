import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/postEntity.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'formSubmitBtn.dart';
import 'TextFormFiledWidget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _TitleController = TextEditingController();
  TextEditingController _BodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _TitleController.text = widget.post!.title;
      _BodyController.text = widget.post!.title;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFiledWidget(name:'Title',multilines: false ,controller : _TitleController),
          TextFormFiledWidget(name:'Body',multilines: true ,controller : _BodyController),

          FormSubmitBtn (isUpdatePost:widget.isUpdatePost ,onPressed: validateFormThenUpdateOrDelete)

        ],
      ),
    );
  }
  void validateFormThenUpdateOrDelete() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id:null ,
        title: _TitleController.text,
        body: _BodyController.text,
      );
      if (widget.isUpdatePost) {

        return  BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        return  BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));}
    }
  }
}
