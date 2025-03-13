import 'package:flutter/material.dart';

class DateTimeFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onTap;

  const DateTimeFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintText: hintText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        enabled: false, // Empêche la saisie au clavier, on veut forcer l’utilisateur à cliquer
      ),
    );
  }
}
