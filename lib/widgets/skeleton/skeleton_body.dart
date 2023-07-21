import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonBody extends StatelessWidget {
  const SkeletonBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(width: 180.0, height: 150.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              height: 16,
              width: 180.0,
              borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              height: 16,
              width: 180.0,
              borderRadius: BorderRadius.circular(10)),
        )
      ],
    );
  }
}
