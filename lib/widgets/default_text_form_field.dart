import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String? Function(String?)? validator;
  String hinttext;
  bool isPassword;
  DefaultTextFormField(
      {required this.controller,
      required this.hinttext,
      this.validator,
      this.isPassword = false});

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool obscureText = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hinttext,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    obscureText = !obscureText;
                    setState(() {});
                  },
                 icon: Icon( obscureText? Icons.visibility_outlined : Icons.visibility_off_outlined))
              : null),
    );
  }
}
