import 'package:e_shoppy/app/modules/auth/controller/auth_controller/auth_controller.dart';
import 'package:e_shoppy/app/modules/auth/controller/bear_controller/bear_log_in_controller.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/logo_text_widget.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/sign_up_text.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/signin_button.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/tracking_text_input.dart';
import 'package:e_shoppy/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildLoginForm(AuthContrller ctrl, ThemeData theme,
    BuildContext context, BearLoginController bearLoginController) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const AppLogoTextWidget(
              text: "Login",
            ),
            15.verticalSpace,
            TrackingTextInput(
              validator: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  return "Email is required";
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return "Incorect Format";
                } else {
                  return null;
                }
              },
              icon: Icons.email_outlined,
              fill: LightThemeColors.buttonDisabledColor.withOpacity(.1),
              label: "Email",
              hint: "Enter Your Email",
              onCaretMoved: (Offset? caret) {
                bearLoginController.coverEyes(caret == null);
                bearLoginController.lookAt(caret);
              },
              onChanged: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  ctrl.isValidatedEmail(false, emailValue: null);
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  ctrl.isValidatedEmail(false, emailValue: null);
                } else {
                  ctrl.isValidatedEmail(true, emailValue: value);
                }
              },
            ),
            TrackingTextInput(
              validator: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  return "Password is required";
                } else if (value.length < 8) {
                  return "Enter 8 digits password";
                } else {
                  return null;
                }
              },
              icon: Icons.password_outlined,
              fill: LightThemeColors.buttonDisabledColor.withOpacity(.1),
              label: "Password",
              hint: "Enter Your Password",
              isObscured: true,
              onCaretMoved: (Offset? caret) {
                bearLoginController.coverEyes(caret != null);
                bearLoginController.lookAt(null);
              },
              onChanged: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  ctrl.isValidatedPassWord(false, passcode: null);
                } else if (value.length < 8) {
                  ctrl.isValidatedPassWord(false, passcode: null);
                } else {
                  ctrl.isValidatedPassWord(true, passcode: value);
                }
              },
              onTextChanged: (String value) {
                bearLoginController.setPassword(value);
              },
            ),
            SigninButton(
              child: Text(
                "Sign In",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                // bearLoginController.submitPassword();
                final offset = Offset(
                  MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 2,
                );
                FocusScope.of(context).unfocus();
                bearLoginController.coverEyes(offset == null);
                bearLoginController.lookAt(offset);
                await ctrl.loginUser(bearLoginController);
              },
            ),
            15.verticalSpace,
            SignUpTextWidget(
              theme: theme,
              text: "Don't Have An Account!",
              text2: "Sign Up",
            ),
          ],
        ),
      ),
    ),
  );
}
