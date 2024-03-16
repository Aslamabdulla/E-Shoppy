import 'package:e_shoppy/app/modules/home/views/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Home',
              icon: Icons.home_filled,
            ),
            20.verticalSpace,
            GetBuilder<HomeController>(builder: (ctrll) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  mainAxisExtent: ctrll.isLoading ? 180.h : 260.h,
                ),
                shrinkWrap: true,
                primary: false,
                itemCount: ctrll.isLoading ? 8 : controller.products.length,
                itemBuilder: (context, index) => ctrll.isLoading
                    ? const ProductItemShimmer()
                    : ProductItem(
                        product: ctrll.products[index],
                      ),
              );
            }),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
