import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_problem/authentication/ui/sign_in_page.dart';
import 'package:no_problem/what_we_do/what_we_do_page.dart';

import 'nav_bar_item.dart';
import 'nav_bar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 60),
              GestureDetector(
                onTap: () => Get.to(() => Scaffold()),
                child: const NavBarItem('Team'),
              ),
              const SizedBox(width: 60),
              GestureDetector(
                onTap: () => Get.to(() => const WhatWeDoPage()),
                child: const NavBarItem('What we do'),
              ),
              const SizedBox(width: 60),
              GestureDetector(
                onTap: () => Get.to(() => const SignInPage()),
                child: const NavBarItem('Sign In'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
