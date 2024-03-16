import 'package:e_shoppy/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/constants/constants.dart';
import '../data/models/product_model/product_model.dart';
import '../modules/base/controllers/base_controller.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                Image.network(
                  product?.image ?? "",
                  height: 150.h,
                  fit: BoxFit.contain,
                ).animate().slideX(
                      duration: const Duration(milliseconds: 200),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                Positioned(
                  left: 10.w,
                  bottom: 10.h,
                  child: GetBuilder<BaseController>(
                    id: 'FavoriteButton',
                    builder: (controller) => GestureDetector(
                      onTap: () => controller.onFavoriteButtonPressed(
                          productId: product?.id ?? -1),
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: LightThemeColors.backgroundColor,
                        child: SvgPicture.asset(
                          product?.isfavourite ?? false
                              ? Constants.favFilledIcon
                              : Constants.favOutlinedIcon,
                          color: product?.isfavourite ?? false
                              ? null
                              : theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ).animate().fade(),
                Positioned(
                  right: 10.w,
                  bottom: 10.h,
                  child: GetBuilder<BaseController>(
                    builder: (controller) => GestureDetector(
                      onTap: () => controller.onAddToCartPressed(product),
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: LightThemeColors.backgroundColor,
                        child: SvgPicture.asset(
                          Constants.cartIcon,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ).animate().fade(),
              ],
            ),
            5.verticalSpace,
            Text(
              product?.title ?? "",
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
            ).animate().fade().slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
            5.verticalSpace,
            Text('\₹ ${product?.price}', style: theme.textTheme.displaySmall)
                .animate()
                .fade()
                .slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 2,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
