import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  TextEditingController controller=TextEditingController();
  String? Function(String?)? validator;
  String hinttext;
   DefaultTextFormField({required this.controller,required this.hinttext,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,decoration: InputDecoration(hintText: hinttext),);
  }
}