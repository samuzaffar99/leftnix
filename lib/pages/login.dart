import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.6],
          colors: [
            Colors.red,
            secondaryColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Leftnix",
            // style: Theme.of(context).textTheme.headline4,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton(
                  prefixIcon: const Icon(Icons.exit_to_app),
                  onPressed: () => Get.toNamed("/"),
                  labelText: "Login",
                ),
                // const Banner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signinForm = fb.group({
      "key": [
        "",
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(64),
      ],
    });
    return ReactiveForm(
      formGroup: signinForm,
      child: Column(
        children: [
          TextFormField(),
          TextFormField(),
          const CustomPasswordTextField(
            formControlName: 'key',
            labelText: "Key",
          ),
        ],
      ),
    );
  }
}
