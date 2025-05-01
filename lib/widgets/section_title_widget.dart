import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Colors.grey[400], thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.grey[400], thickness: 1),
        ),
      ],
    );
  }
}
