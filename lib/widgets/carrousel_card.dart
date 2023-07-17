import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  const CarouselCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500$imageUrl',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
