import 'package:flutter/material.dart';

Widget textFormField(
  String labelText,
  TextEditingController fieldController,
) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: TextFormField(
      style: const TextStyle(fontSize: 17),
      controller: fieldController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      cursorHeight: 17,
    ),
  );
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.labelText,
    required this.fieldController,
  });
  final String labelText;
  final TextEditingController fieldController;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  void _showHidePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        style: const TextStyle(fontSize: 17),
        controller: widget.fieldController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              _showHidePassword();
            },
          ),
        ),
        obscureText: _obscureText,
        cursorHeight: 17,
      ),
    );
  }
}
