import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/general_widgets/centred_view.dart';
import 'package:no_problem/general_widgets/progress_indicators.dart';
import 'package:no_problem/town_council_home/ui/town_council_home_page.dart';

import '../controllers/auth_controller.dart';

class StartUpLogicPage extends StatelessWidget {
  const StartUpLogicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// GetX controllers
    final AuthController _authController = AuthController.to;

    return Obx(() => _authController.firestoreTownCouncil.value == null &&
            _authController.firestoreMediator.value == null
        ? CenteredView(
            child: circularProgressIndicator(context: context),
          )
        : _authController.firestoreTownCouncil.value != null
            ? const TownCouncilHomePage()
            : Scaffold());
  }
}
