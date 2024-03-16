import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color shimmerBaseColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : const Color.fromARGB(255, 169, 130, 130)!;
    Color shimmerHighLight = Theme.of(context).brightness != Brightness.light
        ? Colors.grey[400]!
        : Colors.grey[300]!;

    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighLight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // Reduce border radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120, // Adjust width
              height: 120, // Adjust height
              color: shimmerBaseColor,
            ),
            const SizedBox(height: 5),
            Container(
              width: 120,
              height: 12, // Reduce height
              color: shimmerBaseColor,
            ),
            const SizedBox(height: 5),
            Container(
              width: 70, // Adjust width
              height: 12, // Reduce height
              color: shimmerBaseColor,
            ),
            const SizedBox(height: 5),
            Container(
              width: 40, // Adjust width
              height: 12, // Reduce height
              color: shimmerBaseColor,
            ),
          ],
        ),
      ),
    );
  }
}
