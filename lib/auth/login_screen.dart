import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:todo/widgets/default_elevated_button.dart';
import 'package:todo/widgets/default_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider=Provider.of<SettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              DefaultElevatedButton(text: 'Login', onPressed: Login),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text("Don't have any account"))
            ],
          ),
        ),
      ),
    );
  }

  void Login() {
    if (formKey.currentState!.validate()) {}
  }
}
