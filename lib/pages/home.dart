import 'package:leftnix/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.5, 1],
          colors: [
            primaryColor,
            Colors.black,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "ACM DevDay",
            // style: Theme.of(context).textTheme.headline4,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "hello",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  prefixIcon: const Icon(Icons.event),
                  onPressed: () => Get.toNamed("/events"),
                  labelText: "View Events",
                ),
                CustomButton(
                  prefixIcon: const Icon(Icons.map_outlined),
                  onPressed: () => Get.toNamed("/"),
                  labelText: "Map",
                ),
                const Banner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [Icon(Icons.school)],
      ),
    );
  }
}
