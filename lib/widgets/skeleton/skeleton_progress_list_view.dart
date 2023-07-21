import 'package:flutter/material.dart';
import 'package:streams_cine/widgets/skeleton/skeleton_body.dart';

class SkeletonProgressListView extends StatelessWidget {
  const SkeletonProgressListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.all(10.0),
          child: SkeletonBody(),
        ),
      ),
    );
  }
}
