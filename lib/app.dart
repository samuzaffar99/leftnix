import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/routes.dart';
import 'package:leftnix/widgets.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Leftnix',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: secondaryColor,
      ),
      initialRoute: "/",
      getPages: Nav.routes,
    );
  }
}
