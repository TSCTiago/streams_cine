import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:streams_cine/app/rotes_app.dart';
import 'package:streams_cine/widgets/rating_stars.dart';

import '../models/titles_model.dart';

class TitleCard extends StatelessWidget {
  final TitlesModel title;
  const TitleCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RoutesApp.details, arguments: title);
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    title.imageUrl,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 20),
                      child: Container(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Image.network(
                    title.posterUrl,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ),
            // const Text('Transformers'),
            Row(
              children: [
                const Icon(Icons.date_range),
                const SizedBox(
                  width: 5.0,
                ),
                Text(title.date),
              ],
            ),
            Row(
              children: [
                RatingStars(rating: title.rating),
                const SizedBox(
                  width: 5.0,
                ),
                Text(title.rating)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
