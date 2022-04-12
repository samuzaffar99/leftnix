import 'package:get/get.dart';
import 'pages/home.dart';

class Nav {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const HomePage(),
      transition: Transition.circularReveal,
    ),
  ];
}
