import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../providers/titles_provider.dart';
import 'carrousel_card.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    super.key,
    required this.provider,
  });

  final TitleProvider provider;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: provider.nowPlaying.length,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          CarouselCard(
        title: provider.nowPlaying[itemIndex].title,
        imageUrl: provider.nowPlaying[itemIndex].imageUrl,
      ),
    );
  }
}
