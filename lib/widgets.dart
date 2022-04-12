import 'package:flutter/material.dart';

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
