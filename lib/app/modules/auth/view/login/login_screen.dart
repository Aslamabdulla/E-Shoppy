import 'dart:developer';
import 'package:e_shoppy/app/modules/auth/controller/bear_controller/bear_log_in_controller.dart';
import 'package:e_shoppy/app/modules/auth/controller/auth_controller/auth_controller.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/background_widget.dart';
import 'package:e_shoppy/app/modules/auth/view/widgets/login_form_widget.dart';

import 'package:e_shoppy/utils/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late BearLoginController _bearLoginController;
  @override
  initState() {
    _bearLoginController = BearLoginController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          final offset = Offset(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2,
          );
          FocusScope.of(context).unfocus();
          _bearLoginController.coverEyes(offset == null);
          _bearLoginController.lookAt(offset);
        },
        onTapDown: (details) {
          Offset? offset =
              Offset(details.globalPosition.dx, details.globalPosition.dy);
          _bearLoginController.coverEyes(offset == null);
          _bearLoginController.lookAt(offset);
        },
        onPanUpdate: (DragUpdateDetails details) {
          if (kDebugMode) {
            log("Touched");
          }
        },
        child: GetBuilder<AuthContrller>(builder: (ctrl) {
          return Stack(
            children: <Widget>[
              const BackGroundWidget(),
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 200,
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: FlareActor(
                            Constants.teddy,
                            shouldClip: false,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.contain,
                            controller: _bearLoginController,
                          )),
                      buildLoginForm(
                          ctrl, theme, context, _bearLoginController),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
