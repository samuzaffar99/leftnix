import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/session.dart';
import 'package:leftnix/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
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
              children: const <Widget>[
                RegistrationForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrationController extends GetxController {
  final registrationForm = fb.group(
    {
      "username": [
        "",
        Validators.required,
        Validators.minLength(3),
        Validators.maxLength(32),
      ],
      "key": [
        "",
        Validators.required,
        Validators.minLength(32),
        Validators.maxLength(84),
      ],
    },
  );

  Future<void> register() async {
    String key = registrationForm.value["key"] as String;
    String username = registrationForm.value["username"] as String;
    final Session session = Get.find<Session>();
    bool existing = await session.register(key, username);
    if (existing) {
      Get.snackbar("Success!", "Account creation successful!");
      Get.offAllNamed("/login");
    } else {
      Get.snackbar("Oops!", "User already exists!");
      print("User already exists!");
    }
  }
}

class RegistrationForm extends GetView<RegistrationController> {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.registrationForm,
      child: Column(
        children: [
          const CustomTextField(
            formControlName: 'username',
            labelText: "Username",
          ),
          const VBox(4),
          const CustomPasswordTextField(
            formControlName: 'key',
            labelText: "Key",
          ),
          ConsumerCustomButton(
            onValidPressed: () => controller.register(),
            labelText: "Register",
          ),
        ],
      ),
    );
  }
}
