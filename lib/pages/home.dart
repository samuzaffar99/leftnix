import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                ...[1, 6, 12].map((e) => const PlanCard()),
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

class Profile {
  String username;
  String password;
  String? expiryDate;

  Profile(this.username, this.password, [this.expiryDate]);
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
                  : Text(profile.expiryDate.toString())
            ],
          ),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text("Yearly Plan"),
            const Text("1 Month"),
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
