import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shoppy/app/data/models/user_model/user_model.dart';
import 'package:e_shoppy/app/modules/auth/controller/bear_controller/bear_log_in_controller.dart';
import 'package:e_shoppy/app/routes/app_pages.dart';
import 'package:e_shoppy/utils/auth_helper/auth_helper.dart';
import 'package:e_shoppy/utils/db_helper/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthContrller extends GetxController {
  static AuthContrller get find => Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  bool isValidEmail = false;
  bool isValidPassWord = false;
  bool isValidSignupEmail = false;
  bool isValidSignUpPassword = false;
  bool isValidSignUpConfirmPassword = false;
  bool isValidName = false;
  String? email;
  String? passWord;
  String? signUpemail;
  String? signUpPassWord;
  String? signUpConfirmPassWord;
  String? signUpName;
  setEmail(String emailText) {
    email = emailText;
    update();
  }

  setPassword(String passwordText) {
    passWord = passwordText;
    update();
  }

  void isValidatedSignUpEmail(bool isValidated, {String? emailValue}) {
    isValidSignupEmail = isValidated;
    signUpemail = emailValue;
    update();
  }

  void isValidatedSignUpPassword(bool isValidated, {String? password}) {
    isValidSignUpPassword = isValidated;
    signUpPassWord = password;
    update();
  }

  void isValidatedSignUpConfirmPassword(bool isValidated, {String? password}) {
    isValidSignUpConfirmPassword = isValidated;
    signUpConfirmPassWord = password;
    update();
  }

  void isValidatedName(bool isValidated, {String? name}) {
    isValidName = isValidated;
    signUpName = name;
    update();
  }

  loginUser(BearLoginController bearCtrl) async {
    try {
      if (isValidEmail && isValidPassWord) {
        if (email == null || email == "") {
          Get.snackbar("Error", "Email is required",
              backgroundColor: Colors.white, colorText: Colors.red);
          return;
        } else if (passWord == null || passWord == "") {
          Get.snackbar("Error", "Password is required",
              backgroundColor: Colors.white, colorText: Colors.red);
          return;
        }
        final isAuth = await AuthService.login(email ?? "", passWord ?? "");
        if (isAuth) {
          bearCtrl.submitPassword(true);
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Get.offNamed(Routes.BASE);
            },
          );
        } else {
          bearCtrl.submitPassword(false);
          Get.snackbar("Error", "Authentication Failed",
              backgroundColor: Colors.white, colorText: Colors.red);
        }
      } else {
        Get.snackbar("Error", "All Fields Required",
            backgroundColor: Colors.white, colorText: Colors.red);
      }
    } catch (e) {
      bearCtrl.submitPassword(false);
      Get.snackbar("Error", "Authentication Failed",
          backgroundColor: Colors.white, colorText: Colors.red);
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  signUpuser(BearLoginController bearCtrl) async {
    try {
      if (isValidName &&
          isValidSignUpPassword &&
          isValidSignupEmail &&
          isValidSignUpConfirmPassword) {
        if (signUpPassWord != signUpConfirmPassWord) {
          Get.snackbar("Error", "Password Not Match",
              backgroundColor: Colors.white, colorText: Colors.red);
          return;
        } else if (signUpName == null || signUpName == "") {
          Get.snackbar("Error", "Name is required",
              backgroundColor: Colors.white, colorText: Colors.red);
          return;
        } else if (signUpPassWord == null || signUpPassWord == "") {
          Get.snackbar("Error", "Password is required",
              backgroundColor: Colors.white, colorText: Colors.red);
          return;
        } else if (signUpConfirmPassWord == null ||
            signUpConfirmPassWord == "") {
          Get.snackbar("Error", "Confirm Password is required",
              backgroundColor: Colors.white, colorText: Colors.red);
          return;
        }
        final isExisting = await DbHelper.doseUserExist(signUpemail ?? "");
        if (!isExisting) {
          final isAuth = await AuthService.register(
              signUpemail ?? "", signUpPassWord ?? "");
          if (isAuth) {
            bearCtrl.submitPassword(true);
            await DbHelper.addUser(UserModel(
                uid: signUpemail ?? "",
                email: signUpemail ?? "",
                name: signUpName,
                dob: "NA",
                mobile: "NA",
                gender: "NA",
                userCreationTime: DateTime.now().toIso8601String()));

            Get.offNamed(Routes.BASE);
          } else {
            bearCtrl.submitPassword(false);
            Get.snackbar("Error", "Authentication Failed",
                backgroundColor: Colors.white, colorText: Colors.red);
          }
        } else {
          Get.snackbar("Error", "User Already Exist",
              backgroundColor: Colors.white, colorText: Colors.red);
        }
      } else {
        Get.snackbar("Error", "All Fields Required",
            backgroundColor: Colors.white, colorText: Colors.red);
      }
    } catch (e) {
      bearCtrl.submitPassword(false);
      Get.snackbar("Error", "Authentication Failed",
          backgroundColor: Colors.white, colorText: Colors.red);
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  void isValidatedEmail(bool isValidated, {String? emailValue}) {
    isValidEmail = isValidated;
    email = emailValue;
    update();
  }

  void isValidatedPassWord(bool isValidated, {String? passcode}) {
    isValidPassWord = isValidated;
    passWord = passcode;
    update();
  }

  late Rx<User?> user;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      //Get.offAll(() => LoginScreen());
    } else {
      //Get.offAll(() => const HomeScreen());
    }
  }

  //Create Account For New User
  Future<void> addUser(UserModel userModel) {
    return DbHelper.addUser(userModel);
  }

  Future<bool> doseUserExist(String uid) => DbHelper.doseUserExist(uid);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      DbHelper.getUserById(uid);

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById2(String uid) =>
      DbHelper.getUserById2(uid);

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DbHelper.updateProfile(uid, map);
}
