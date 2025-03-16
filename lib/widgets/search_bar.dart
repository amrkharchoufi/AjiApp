import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.size,
    required this.controller,
    this.onChanged,
    this.hintText = "Search...",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width * 0.80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.3 * 255).toInt()),
              spreadRadius: 0.2,
              blurRadius: 1,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search,
                color: Colors.black54, size: size.width * 0.06),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
