import 'package:flutter/material.dart';
import 'package:no_problem/config/assets.dart';
import 'package:no_problem/general_widgets/centred_view.dart';

class WhatWeDoPage extends StatelessWidget {
  const WhatWeDoPage({Key? key}) : super(key: key);

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
        child: Image.asset(Assets.whatWeDoDesktop1),
      ),
    );
  }
}
