import 'package:flutter/material.dart';
import 'package:no_problem/base/widgets/home_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    final Shader linearGradient = const LinearGradient(
      colors: <Color>[
        Colors.greenAccent,
        Colors.green,
      ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 1000.0, 70.0));

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: _mediaQuery.size.height * 0.05),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: _mediaQuery.size.width * 0.05),
            child: const HomeDetails(),
          ),
          SizedBox(height: _mediaQuery.size.height * 0.10),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: _mediaQuery.size.height * 0.14),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '© 2022 No Problem. All rights reserved.',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
