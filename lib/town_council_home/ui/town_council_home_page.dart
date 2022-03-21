import 'package:flutter/material.dart';
import 'package:no_problem/authentication/controllers/auth_controller.dart';
import 'package:no_problem/general_widgets/buttons/elongated_button.dart';
import 'package:no_problem/general_widgets/centred_view.dart';
import 'package:no_problem/town_council_home/ui/town_council_complaints_feed.dart';

import '../../config/assets.dart';

class TownCouncilHomePage extends StatelessWidget {
  const TownCouncilHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    /// GetX Controllers
    final AuthController _authController = AuthController.to;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.asset(Assets.logo).image,
            ),
            SizedBox(width: _mediaQuery.size.width * 0.01),
            const Text(
              'No Problem (Town Council)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(_mediaQuery.size.width * 0.005),
            child: ElongatedButton(
              text: "Sign Out",
              onPressed: () => _authController.signOut(),
              buttonColour: Colors.red,
              textColour: Colors.white,
            ),
          ),
        ],
      ),
      body: CenteredView(
        child: Column(
          children: [
            Image.asset(Assets.pdpaReminder),
            const TownCouncilComplaintsFeed(),
          ],
        ),
      ),
    );
  }
}
