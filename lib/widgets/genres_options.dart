import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streams_cine/providers/titles_provider.dart';

class GenresOption extends StatelessWidget {
  final String text;
  const GenresOption({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TitleProvider>(context, listen: true);
    return Container(
      width: 150.0,
      height: 50.0,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: text == provider.genreSelected
              ? Colors.grey
              : Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
