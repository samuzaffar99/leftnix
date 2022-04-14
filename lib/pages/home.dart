import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/model.dart';
import 'package:leftnix/session.dart';
import 'package:leftnix/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Get.find<Session>();
    final Profile _profile = session.profile!;
    return Container(
      decoration: backgroundDecor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Leftnix",
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
                UserBanner(
                  profile: _profile,
                ),
                ...[
                  Plan("1 Month", 2, 1),
                  Plan("6 Month", 5, 6),
                  Plan("12 Month", 9, 12),
                ].map((e) => PlanCard(plan: e)),
                CustomButton(
                  prefixIcon: const Icon(Icons.exit_to_app),
                  onPressed: () => Get.offAllNamed("/login"),
                  labelText: "Logout",
                ),
                // const Banner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserBanner extends StatelessWidget {
  final Profile profile;

  const UserBanner({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                profile.username,
                textAlign: TextAlign.center,
              ),
              profile.expiryDate == null
                  ? const Text("Not Subscribed")
                  : Text(profile.expiryDate.toString()),
              CustomButton(
                onPressed: () {
                  final session = Get.find<Session>();
                  session.getBalance();
                },
                labelText: "Fetch Balance",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeController extends GetxController {
  Profile user = Profile("coolsam360", "123");

  void subscribe(Plan plan) {
    final session = Get.find<Session>();
    final user = session.profile!;
    DateTime newDate = user.expiryDate == null
        ? DateTime.now()
        : DateTime.parse(user.expiryDate!);
    newDate = newDate.add(Duration(days: plan.duration * 30));
    session.subscribe(newDate);
    return;
  }
}

class PlanCard extends GetView<HomeController> {
  const PlanCard({Key? key, required this.plan}) : super(key: key);
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(plan.name),
            Text(plan.duration.toString()),
            Text(plan.cost.toString()),
            CustomButton(
              prefixIcon: const Icon(Icons.monetization_on_outlined),
              onPressed: () => controller.subscribe(plan),
              labelText: "Subscribe",
              primary: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
