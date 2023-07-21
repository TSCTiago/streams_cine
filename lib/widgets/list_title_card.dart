import 'package:flutter/material.dart';
import 'package:streams_cine/widgets/title_card.dart';

import '../models/titles_model.dart';

class ListTitleCard extends StatelessWidget {
  final List<TitlesModel> list;
  const ListTitleCard({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) =>
            TitleCard(title: list[index]),
      ),
    );
  }
}
