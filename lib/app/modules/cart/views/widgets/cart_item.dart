import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/constants.dart';
import '../../../../data/models/product_model/product_model.dart';
import '../../controllers/cart_controller.dart';

class CartItem extends GetView<CartController> {
  final ProductModel? product;
  const CartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 90.w,
                  height: 145.h,
                  color: Colors.white,
                ),
                Image.network(
                  product?.image ?? "",
                  height: 110.h,
                  width: 90.w,
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.verticalSpace,
              SizedBox(
                width: ScreenUtil().screenWidth / 2.4,
                child: Text(
                  product?.title ?? "",
                  style: theme.textTheme.displayMedium?.copyWith(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              5.verticalSpace,
              Text('Size: ${product?.size}',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp)),
              5.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\₹ ${product?.price}',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                  10.verticalSpace,
                  GetBuilder<CartController>(
                    id: 'ProductQuantity',
                    builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              controller.onIncreasePressed(product?.id ?? -1),
                          child: SvgPicture.asset(Constants.decreaseIcon),
                        ),
                        10.horizontalSpace,
                        Text('${product?.quantity}',
                            style: theme.textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.w800)),
                        10.horizontalSpace,
                        GestureDetector(
                          onTap: () =>
                              controller.onDecreasePressed(product?.id ?? -1),
                          child: SvgPicture.asset(Constants.increaseIcon),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              InkWell(
                onTap: () => controller.onDeletePressed(product?.id ?? -1),
                customBorder: const CircleBorder(),
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    Constants.cancelIcon,
                    width: 20.w,
                    height: 20.h,
                    color: theme.textTheme.bodyMedium!.color,
                  ),
                ),
              ),
              30.verticalSpace,
              Text(
                "Total",
                style: theme.textTheme.displayLarge
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "₹ ${((product?.quantity ?? 0) * (product?.price ?? 0).roundToDouble()).toString()}",
                    style: theme.textTheme.displayLarge
                        ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
