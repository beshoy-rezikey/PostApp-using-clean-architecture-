import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdatePost ;
  final   void Function() onPressed ;
  const FormSubmitBtn({Key? key, required this.isUpdatePost, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    ElevatedButton.icon(
      onPressed: onPressed,
      icon:isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
      label: isUpdatePost ? Text('Update') : Text('Add'),
    );
  }
}
