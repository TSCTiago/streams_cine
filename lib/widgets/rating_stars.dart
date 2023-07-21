import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStars extends StatelessWidget {
  final String rating;
  const RatingStars({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: double.parse(rating) / 2,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Theme.of(context).primaryColor,
      ),
      itemCount: 5,
      itemSize: 24.0,
      direction: Axis.horizontal,
    );
  }
}
