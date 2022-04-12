import 'package:get/get.dart';
import 'package:leftnix/pages/login.dart';

import 'pages/home.dart';

class Nav {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.circularReveal,
    ),
  ];
}
