import 'package:flutter/material.dart';
import 'package:no_problem/config/assets.dart';
import 'package:no_problem/general_widgets/centred_view.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: CenteredView(
        child: ListView(
          children: [
            const Text(
              "THE TEAM",
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Image.asset(Assets.team),
          ],
        ),
      ),
    );
  }
}
