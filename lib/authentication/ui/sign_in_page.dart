import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/authentication/controllers/auth_controller.dart';
import 'package:no_problem/config/assets.dart';

import '../../config/ui_helpers.dart';
import '../../general_widgets/buttons/busy_button.dart';
import '../../general_widgets/centred_view.dart';
import '../../general_widgets/input_fields/input_field.dart';
import '../../general_widgets/text_link.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    /// GetX Controllers
    final AuthController _authController = AuthController.to;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.asset(Assets.logo).image,
            ),
            SizedBox(width: _mediaQuery.size.width * 0.01),
            const Text(
              'No Problem',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.greenAccent,
      body: CenteredView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(350, 0, 350, 0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                top: _mediaQuery.size.height * 0.0001,
                bottom: _mediaQuery.size.height * 0.0001),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 500),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    verticalSpaceTiny,
                    const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpaceSmall,
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    verticalSpaceLarge,
                    InputField(
                      placeholder: 'Email',
                      controller: _authController.emailTextController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: _authController.passwordTextController,
                    ),
                    verticalSpaceMedium,
                    BusyButton(
                      title: 'Sign in',
                      busy: false,
                      onTap: () =>
                          _authController.signInWithEmailAndPassword(context),
                      color: Colors.greenAccent,
                    ),
                    verticalSpaceMedium,
                    TextLink(
                      text: 'Create an Account',
                      onPressed: () => Get.to(() => Scaffold()),
                      color: kcMediumGreyColour,
                    ),
                    verticalSpaceSmall,
                    const Text(
                      'or',
                      style: TextStyle(color: Colors.white),
                    ),
                    verticalSpaceSmall,
                    TextLink(
                      text: 'Forgot password?',
                      onPressed: () => Get.to(() => Scaffold()),
                      color: kcMediumGreyColour,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
