import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../utils/constants/constants.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';
import 'widgets/rounded_button.dart';
import 'widgets/size_item.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      // extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  height: 400.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(top: 0, bottom: 40.h),
                        height: 400.h,
                        width: ScreenUtil().screenWidth * .5,
                        child: Image.network(
                          controller.product.image ?? "",
                          // height: 300.h,
                          fit: BoxFit.contain,
                        ).animate().slideX(
                              duration: const Duration(milliseconds: 300),
                              begin: 1,
                              curve: Curves.easeInSine,
                            ),
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedButton(
                          onPressed: () => Get.back(),
                          child: SvgPicture.asset(Constants.backArrowIcon,
                              fit: BoxFit.none),
                        ),
                        GetBuilder<ProductDetailsController>(
                          id: 'FavoriteButton',
                          builder: (_) => RoundedButton(
                            onPressed: () =>
                                controller.onFavoriteButtonPressed(),
                            child: Align(
                              child: SvgPicture.asset(
                                controller.product?.isfavourite ?? false
                                    ? Constants.favFilledIcon
                                    : Constants.favOutlinedIcon,
                                width: 16.w,
                                height: 15.h,
                                color: controller.product.isfavourite ?? true
                                    ? null
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(controller.product?.title ?? "",
                      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16))
                  .animate()
                  .fade()
                  .slideX(
                    duration: const Duration(milliseconds: 300),
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    '₹${controller.product.price}',
                    style: theme.textTheme.displayMedium,
                  ),
                  30.horizontalSpace,
                  const Icon(Icons.shopping_bag_outlined,
                      color: Colors.redAccent),
                  Text(
                    controller.product.rating?.count.toString() ?? "",
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  5.horizontalSpace,
                  const Icon(Icons.star_rounded, color: Color(0xFFFFC542)),
                  Text(
                    '(${controller.product.rating?.rate})',
                    style:
                        theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                  ),
                ],
              ).animate().fade().slideX(
                    duration: const Duration(milliseconds: 300),
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Choose your size:',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ).animate().fade().slideX(
                    duration: const Duration(milliseconds: 300),
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GetBuilder<ProductDetailsController>(
                id: 'Size',
                builder: (_) => Row(
                  children: [
                    SizeItem(
                      onPressed: () => controller.changeSelectedSize('S'),
                      label: 'S',
                      selected: controller.selectedSize == 'S',
                    ),
                    10.horizontalSpace,
                    SizeItem(
                      onPressed: () => controller.changeSelectedSize('M'),
                      label: 'M',
                      selected: controller.selectedSize == 'M',
                    ),
                    10.horizontalSpace,
                    SizeItem(
                      onPressed: () => controller.changeSelectedSize('L'),
                      label: 'L',
                      selected: controller.selectedSize == 'L',
                    ),
                    10.horizontalSpace,
                    SizeItem(
                      onPressed: () => controller.changeSelectedSize('XL'),
                      label: 'XL',
                      selected: controller.selectedSize == 'XL',
                    ),
                  ],
                ).animate().fade().slideX(
                      duration: const Duration(milliseconds: 300),
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CustomButton(
                text: 'Add to Cart',
                onPressed: () => controller.onAddToCartPressed(),
                disabled: false,
                fontSize: 16.sp,
                radius: 12.r,
                verticalPadding: 12.h,
                hasShadow: true,
                shadowColor: theme.primaryColor,
                shadowOpacity: 0.3,
                shadowBlurRadius: 4,
                shadowSpreadRadius: 0,
              ).animate().fade().slideY(
                    duration: const Duration(milliseconds: 300),
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
