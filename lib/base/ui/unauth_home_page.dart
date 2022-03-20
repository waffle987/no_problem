import 'package:flutter/material.dart';
import 'package:no_problem/general_widgets/centred_view.dart';
import 'package:no_problem/general_widgets/navigation_bar/navigation_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'home_page.dart';

class UnAuthHomePage extends StatelessWidget {
  const UnAuthHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        backgroundColor: Colors.white,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? Container()
            : null,
        body: CenteredView(
          child: Column(
            children: [
              const CustomNavigationBar(),
              SizedBox(height: _mediaQuery.size.height * 0.05),
              Expanded(
                child: ScreenTypeLayout(
                  mobile: Container(),
                  desktop: const HomePage(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
