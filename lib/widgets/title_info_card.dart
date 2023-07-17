import 'package:flutter/material.dart';

class TitleInfoCard extends StatelessWidget {
  final String title;
  final String info;
  const TitleInfoCard({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        Text(
          info,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
