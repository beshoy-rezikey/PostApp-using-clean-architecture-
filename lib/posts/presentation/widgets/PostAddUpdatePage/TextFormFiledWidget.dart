import 'package:flutter/material.dart';

class TextFormFiledWidget extends StatelessWidget {
  final TextEditingController controller;

  final String name;
  final bool multilines;

  const TextFormFiledWidget(
      {Key? key,
      required this.controller,
      required this.name,
      required this.multilines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        minLines: multilines ? 4 :1,
        maxLines:  multilines ? 4:1,
        controller: controller,
        validator: (value) => value!.isEmpty ? '$name cant be empty' : null,
        decoration: InputDecoration(hintText: name),
      ),
    );
  }
}
