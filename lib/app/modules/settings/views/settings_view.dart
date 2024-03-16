import 'package:e_shoppy/app/data/local/my_shared_pref.dart';
import 'package:e_shoppy/app/routes/app_pages.dart';
import 'package:e_shoppy/utils/auth_helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../utils/constants/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Settings',
              dividerEndIndent: 230,
              icon: Icons.settings,
            ),
            20.verticalSpace,
            Text('Account',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                )),
            20.verticalSpace,
            SettingsItem(
              title: AuthService.getuserEmail() ?? "",
              icon: Constants.userIcon,
              isAccount: true,
            ),
            30.verticalSpace,
            Text('Settings',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Language',
              icon: Constants.languageIcon,
            ),
            25.verticalSpace,
            const SettingsItem(
              title: 'Help',
              icon: Constants.helpIcon,
            ),
            25.verticalSpace,
            GestureDetector(
              onTap: () async {
                MySharedPref.setThemeIsLight(true);

                Get.changeThemeMode(ThemeMode.light);
                await AuthService.logout();
                Get.offNamed(Routes.LOGIN);
              },
              child: const SettingsItem(
                title: 'Sign Out',
                icon: Constants.logoutIcon,
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
