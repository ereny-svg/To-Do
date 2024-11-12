import 'package:flutter/material.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/widgets/default_elevated_button.dart';
import 'package:todo/widgets/default_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return 'Email can not be less than 5 characters';
                    }
                    return null;
                  },
                  controller: nameController,
                  hinttext: 'Name'),
              const SizedBox(
                height: 16,
              ),
              DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return 'Email can not be less than 2 characters';
                    }
                    return null;
                  },
                  controller: emailController,
                  hinttext: 'Email'),
              const SizedBox(
                height: 16,
              ),
              DefaultTextFormField(
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Password can not be less than 8 characters';
                    }
                    return null;
                  },
                  isPassword: true,
                  controller: PasswordController,
                  hinttext: 'Password'),
              const SizedBox(
                height: 32,
              ),
              DefaultElevatedButton(text: 'Register', onPressed: Register),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text("Already have any account"))
            ],
          ),
        ),
      ),
    );
  }

  void Register() {
    if (formKey.currentState!.validate()) {}
  }
}
