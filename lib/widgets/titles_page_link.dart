import 'package:flutter/material.dart';

import '../app/rotes_app.dart';
import '../models/titles_model.dart';
import 'title_type.dart';

class TitlesPageLink extends StatelessWidget {
  final String titleText;
  final List<Map<String, dynamic>> genres;
  final List<TitlesModel> titlesList;
  const TitlesPageLink({
    super.key,
    required this.genres,
    required this.titlesList,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(RoutesApp.titlesPages,
          arguments: {'titlesList': titlesList, 'genres': genres}),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleType(type: titleText),
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
