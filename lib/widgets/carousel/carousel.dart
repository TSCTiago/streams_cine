import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../providers/titles_provider.dart';
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
      itemCount: provider.nowPlaying.isEmpty ? 1 : provider.nowPlaying.length,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          provider.nowPlaying.isEmpty
              ? const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        width: double.infinity, height: double.infinity),
                  ),
                )
              : CarouselCard(
                  title: provider.nowPlaying[itemIndex].title,
                  imageUrl: provider.nowPlaying[itemIndex].imageUrl,
                ),
    );
  }
}
