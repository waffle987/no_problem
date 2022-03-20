import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/general_widgets/centred_view.dart';
import 'package:no_problem/general_widgets/progress_indicators.dart';

import 'authentication/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Get.put<AuthController>(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'No Problem',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CenteredView(
        child: circularProgressIndicator(context: context),
      ),
    );
  }
}
