import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leftnix/chain.dart';
import 'package:leftnix/model.dart';
import 'package:leftnix/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Profile _profile = Profile("coolsam360", "123");
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.6],
          colors: [
            Colors.red,
            secondaryColor,
          ],
        ),
      ),
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
                  Plan("12 Month", 9, 12)
                ].map((e) => PlanCard(plan: e)),
                CustomButton(
                  prefixIcon: const Icon(Icons.exit_to_app),
                  onPressed: () => Get.toNamed("/"),
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
                  final network = Get.find<Network>();
                  network.getBalance();
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

class PlanCard extends StatelessWidget {
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
              onPressed: () {},
              labelText: "Subscribe",
              primary: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
