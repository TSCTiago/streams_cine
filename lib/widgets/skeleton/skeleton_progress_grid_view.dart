import 'package:flutter/material.dart';
import 'package:streams_cine/widgets/skeleton/skeleton_body.dart';

class SkeletonProgressGridView extends StatelessWidget {
  const SkeletonProgressGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return const SkeletonBody();
        },
      ),
    );
  }
}

          // child: SkeletonBody(),