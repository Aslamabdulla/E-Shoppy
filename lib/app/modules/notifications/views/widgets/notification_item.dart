import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/constants.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        title: Text(
          'New Notification received\nyour cart waiting for checkout',
          style: theme.textTheme.displaySmall
              ?.copyWith(fontWeight: FontWeight.normal, fontSize: 12.sp),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text(
            '15/03/2024 AT 05:30 PM',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 10.sp,
            ),
          ),
        ),
        leading: Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              Constants.notificationsIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
