import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/app.dart';
import 'package:leftnix/chain.dart';

Future<void> main() async {
  await initializeServices();
  runApp(const App());
}

Future<void> initializeServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => Network().init());
}
