

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double height = 40;
  final bgColor;
  Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = const Color(0xFFFFFFFF)
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(bgColor),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(color: Color(0xFF000000))
              )
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 20)
          ),
          minimumSize: WidgetStateProperty.all<Size>(Size(120, height)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'OpenSans'
            )
          ),
        )
    );
  }
}
