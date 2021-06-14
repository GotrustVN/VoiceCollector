import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  AppButton({Key? key, required this.text, this.onButtonPressed})
      : super(key: key);

  final VoidCallback? onButtonPressed;
  final String text;
  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        color: Colors.blue
      ),
      child: TextButton(
        onPressed: widget.onButtonPressed,
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
    );
  }
}
