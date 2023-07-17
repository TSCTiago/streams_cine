import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonProgress extends StatelessWidget {
  const SkeletonProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ),
        ));
  }
}
