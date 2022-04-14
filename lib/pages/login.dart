import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/chain.dart';
import 'package:leftnix/secrets.dart';
import 'package:leftnix/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Container(
      decoration: backgroundDecor,
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
                const LoginForm(),
                const Text("OR"),
                CustomButton(
                  prefixIcon: const Icon(Icons.app_registration),
                  onPressed: () => Get.toNamed("/register"),
                  labelText: "Register Now",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginController extends GetxController {
  final loginForm = fb.group(
    {
      "key": [
        privateKey,
        Validators.required,
        Validators.minLength(32),
        Validators.maxLength(84),
      ],
    },
  );

  Future<void> login() async {
    String key = loginForm.value["key"] as String;
    String username = loginForm.value["username"] as String;
    final Session network = Get.find<Session>();
    bool existing = await network.register(key,username);
    if (existing) {
      Get.offAllNamed("/home");
    } else {
      print("User does not exist!");
    }
  }
}

class LoginForm extends GetView<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.loginForm,
      child: Column(
        children: [
          const CustomPasswordTextField(
            formControlName: 'key',
            labelText: "Key",
          ),
          ConsumerCustomButton(
            onValidPressed: () => controller.login(),
            labelText: "Login",
          ),
        ],
      ),
    );
  }
}
