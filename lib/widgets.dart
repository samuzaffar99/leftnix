import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// const primaryColor = Color.fromRGBO(201, 8, 61, 1);
// const secondaryColor = Color.fromRGBO(9, 55, 117, 1);

const primaryColor = Colors.redAccent;
const secondaryColor = Colors.blueAccent;

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String labelText;
  final Color primary;
  final Widget? prefixIcon;
  final bool icon;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.labelText,
    this.primary = primaryColor,
    this.prefixIcon,
    this.icon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: prefixIcon,
                //Icon(prefixIcon, color: Colors.black),
              ),
            Text(labelText, textScaleFactor: 1.1),
            const Spacer(),
            if (icon)
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          primary: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // elevation: 0,
        ),
      ),
    );
  }
}

class HBox extends StatelessWidget {
  final double width;

  const HBox(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class VBox extends StatelessWidget {
  final double height;

  const VBox(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class CustomInputDecor extends InputDecoration {
  const CustomInputDecor({String? labelText, Widget? suffix})
      : super(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 1.5),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          labelStyle: const TextStyle(color: primaryColor),
          suffix: suffix,
          labelText: labelText,
        );
}

class CustomInputDecorObscured extends CustomInputDecor {
  CustomInputDecorObscured({
    String? labelText,
    Widget? suffix,
    bool isObscured = false,
    required void Function()? onPressed,
  }) : super(
          suffix: InkWell(
            onTap: onPressed,
            child: isObscured
                ? const Icon(Icons.visibility, color: primaryColor)
                : const Icon(Icons.visibility_off, color: Colors.grey),
          ),
          // suffix: IconButton(
          //   padding: EdgeInsets.zero,
          //   constraints: const BoxConstraints(),
          //   icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off, color:Colors.grey),
          //   onPressed: onPressed,
          // ),
          labelText: labelText,
        );
}

class ConsumerCustomButton extends StatelessWidget {
  const ConsumerCustomButton(
      {Key? key, required this.labelText, this.onValidPressed})
      : super(key: key);
  final String labelText;
  final void Function()? onValidPressed;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return CustomButton(
          onPressed: form.valid ? onValidPressed : null,
          labelText: labelText,
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, this.formControlName, this.labelText, this.validationMessages})
      : super(key: key);
  final String? formControlName;
  final String? labelText;
  final Map<String, String> Function(FormControl<dynamic>)? validationMessages;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      decoration: CustomInputDecor(
        labelText: labelText,
      ),
      validationMessages: validationMessages,
    );
  }
}

// TODO Convert to use GetX
class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField(
      {Key? key, this.formControlName, this.labelText, this.validationMessages})
      : super(key: key);
  final String? formControlName;
  final String? labelText;
  final Map<String, String> Function(FormControl<dynamic>)? validationMessages;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: widget.formControlName,
      decoration: CustomInputDecorObscured(
        labelText: widget.labelText,
        onPressed: () {
          setState(() => obscured = !obscured);
        },
        isObscured: obscured,
      ),
      validationMessages: widget.validationMessages,
      obscureText: obscured,
    );
  }
}
