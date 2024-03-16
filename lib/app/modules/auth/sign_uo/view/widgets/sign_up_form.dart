import 'package:e_shoppy/app/modules/auth/controller/auth_controller/auth_controller.dart';
import 'package:e_shoppy/app/modules/auth/controller/bear_controller/bear_log_in_controller.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/logo_text_widget.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/sign_up_text.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/signin_button.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/tracking_text_input.dart';
import 'package:e_shoppy/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container buildSignUpForm(AuthContrller ctrl, ThemeData theme,
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
            const AppLogoTextWidget(text: "Sign UP"),
            15.verticalSpace,
            TrackingTextInput(
              validator: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  return "Name is required";
                } else if (!RegExp(r'^[a-zA-Z\s]*[a-zA-Z][a-zA-Z\s]*$')
                    .hasMatch(value)) {
                  return "Only letters are allowed";
                } else {
                  return null;
                }
              },
              icon: Icons.email_outlined,
              fill: LightThemeColors.buttonDisabledColor.withOpacity(.1),
              label: "Username",
              hint: "Enter Your Name",
              onCaretMoved: (Offset? caret) {
                bearLoginController.coverEyes(caret == null);
                bearLoginController.lookAt(caret);
              },
              onChanged: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  ctrl.isValidatedName(false, name: null);
                } else if (!RegExp(r'^[a-zA-Z\s]*[a-zA-Z][a-zA-Z\s]*$')
                    .hasMatch(value)) {
                  ctrl.isValidatedName(false, name: null);
                } else {
                  ctrl.isValidatedName(true, name: value);
                }
              },
            ),
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
                  ctrl.isValidatedSignUpEmail(false, emailValue: null);
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  ctrl.isValidatedSignUpEmail(false, emailValue: null);
                } else {
                  ctrl.isValidatedSignUpEmail(true, emailValue: value);
                }
              },
            ),
            TrackingTextInput(
              validator: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  return "Password is required";
                } else if (value.length < 8) {
                  return "8 digits required";
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
              onTextChanged: (String value) {
                bearLoginController.setPassword(value);
              },
              onChanged: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  ctrl.isValidatedSignUpPassword(false, password: null);
                } else if (value.length < 8) {
                  ctrl.isValidatedSignUpPassword(false, password: null);
                } else {
                  ctrl.isValidatedSignUpPassword(true, password: value);
                }
              },
            ),
            TrackingTextInput(
              validator: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  return "Password is required";
                } else if (value.length < 8) {
                  return "8 digits required";
                } else {
                  return null;
                }
              },
              icon: Icons.password_outlined,
              fill: LightThemeColors.buttonDisabledColor.withOpacity(.1),
              label: "Confirm Password",
              hint: "Re-enter Your Password",
              isObscured: true,
              onCaretMoved: (Offset? caret) {
                bearLoginController.coverEyes(caret != null);
                bearLoginController.lookAt(null);
              },
              onTextChanged: (String value) {
                bearLoginController.setPassword(value);
              },
              onChanged: (value) {
                if ((value?.isEmpty ?? true) || value == null) {
                  ctrl.isValidatedSignUpConfirmPassword(false, password: null);
                } else if (value.length < 8) {
                  ctrl.isValidatedSignUpConfirmPassword(false, password: null);
                } else {
                  ctrl.isValidatedSignUpConfirmPassword(true, password: value);
                }
              },
            ),
            SigninButton(
              child: Text(
                "Sign Up",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                final offset = Offset(
                  MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 2,
                );
                FocusScope.of(context).unfocus();
                bearLoginController.coverEyes(offset == null);
                bearLoginController.lookAt(offset);
                ctrl.signUpuser(bearLoginController);
              },
            ),
            15.verticalSpace,
            SignUpTextWidget(
              theme: theme,
              text: "Already Have An Account!",
              text2: "Login",
            ),
          ],
        ),
      ),
    ),
  );
}
